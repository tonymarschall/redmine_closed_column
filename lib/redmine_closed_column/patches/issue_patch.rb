module RedmineClosedColumn
  module Patches
    module IssuePatch
      
      def closed_date
	if IssueStatus.find(status_id).is_closed
          _sql = "SELECT journals.created_on FROM journals, journal_details WHERE journals.journalized_id = #{id} AND journals.id = journal_details.journal_id AND journal_details.prop_key = 'status_id' AND journal_details.property = 'attr' AND journal_details.value IN (SELECT is_close.id FROM issue_statuses is_close WHERE is_close.is_closed = 1) ORDER BY journals.created_on DESC LIMIT 1,1"
	  result = ActiveRecord::Base.connection.select_value _sql
          unless result.nil?
            @closed_date ||= result
          end
	end
      end
      
    end
  end
end
