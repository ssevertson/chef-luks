#
# Cookbook Name:: luks
# Provider:: device
#
# Copyright 2013, Intoximeters, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


class Chef::Exceptions::LUKS < RuntimeError; end

action :create do
  if !@current_resource.exists
    converge_by("Creating #{@new_resource}") do
      luks_format_device
    end
  elsif !@current_resource.open
    converge_by("Opening #{@new_resource}") do
      luks_open_device
    end
  else
    Chef::Log.info "#{@new_resource} already exists and is already open - nothing to do."
  end  
end

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::LuksDevice.new(@new_resource.name)
  @current_resource.key_file(@new_resource.key_file)
  @current_resource.luks_name(@new_resource.luks_name)

  if is_luks_device? @current_resource.block_device
    @current_resource.exists = true
    
    if is_luks_open? @current_resource.luks_name
      @current_resource.open = true
    end
  end
end

def is_luks_device?(block_device)
  cmd = Mixlib::ShellOut.new(
    '/sbin/cryptsetup', 'isLuks', block_device
    ).run_command

  cmd.exitstatus == 0
end

def is_luks_open?(luks_name)
  cmd = Mixlib::ShellOut.new(
    '/sbin/cryptsetup', 'status', luks_name
    ).run_command
  cmd.exitstatus == 0
end

def update_crypttab(block_device, luks_name, key_file)
  file = Chef::Util::FileEdit.new('/etc/crypttab')
  file.insert_line_if_no_match(
    "^#{luks_name}\t#{block_device}\t#{key_file}",
    "#{luks_name}\t#{block_device}\t#{key_file}\tluks"
  )
  file.write_file
end

def luks_open_device
  cmd = Mixlib::ShellOut.new(
    '/sbin/cryptsetup', '-q', '-d', new_resource.key_file, 'luksOpen',
    new_resource.block_device, new_resource.luks_name).run_command

  raise Chef::Exceptions::LUKS.new cmd.stderr if cmd.exitstatus != 0

  update_crypttab new_resource.block_device,
    new_resource.luks_name, new_resource.key_file
end

def luks_format_device
  cmd = Mixlib::ShellOut.new(
    '/sbin/cryptsetup', '-q', 'luksFormat',
    new_resource.block_device, new_resource.key_file).run_command

  if cmd.exitstatus == 0
    luks_open_device
  else
    raise Chef::Exceptions::LUKS.new cmd.stderr
  end
end
