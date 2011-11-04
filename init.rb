require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  Issue.send(:include, RedmineClosedColumn::Patches::IssuePatch) unless Issue.include?(RedmineClosedColumn::Patches::IssuePatch)
  Query.send(:include, RedmineClosedColumn::Patches::QueryPatch) unless Query.include?(RedmineClosedColumn::Patches::QueryPatch)
end

Redmine::Plugin.register :redmine_closed_column do
  name 'Redmine Issue closed column'
  author 'Tony Marschall'
  description 'This plugin adds a first closed date column to issue lists.'
  version '0.1'
end
