module RedmineClosedColumn
  module Patches
    module IssuePatch
      
      def first_closed_date
        _sql = "SELECT journals.created_on FROM journals, journal_details WHERE journals.journalized_id = #{id} AND journals.id = journal_details.journal_id AND journal_details.prop_key = 'status_id' AND journal_details.property = 'attr' AND journal_details.value IN (SELECT is_close.id FROM issue_statuses is_close WHERE is_close.is_closed = 1) ORDER BY journals.created_on DESC LIMIT 1"
	    result = ActiveRecord::Base.connection.select_value _sql
        unless result.nil?
          @first_closed_date ||= format_time(result, true)
        end
      end

      def last_closed_date
        _sql = "SELECT journals.created_on FROM journals, journal_details WHERE journals.journalized_id = #{id} AND journals.id = journal_details.journal_id AND journal_details.prop_key = 'status_id' AND journal_details.property = 'attr' AND journal_details.value IN (SELECT is_close.id FROM issue_statuses is_close WHERE is_close.is_closed = 1) ORDER BY journals.created_on LIMIT 1"
	    result = ActiveRecord::Base.connection.select_value _sql
        unless result.nil?
          @last_closed_date ||= format_time(result, true)
        end
      end
      
    end
  end
end
