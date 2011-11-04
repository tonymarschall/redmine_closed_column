module RedmineClosedColumn
  module Patches
    module QueryPatch
      
      def available_columns_with_closed_date
        returning available_columns_without_closed_date do |columns|
          columns << QueryColumn.new(:closed_date,
            :caption => :label_closed_date,
	    :sortable => "(SELECT journals.created_on FROM journals, journal_details WHERE journals.journalized_id = t0_r0 AND journals.id = journal_details.journal_id AND journal_details.prop_key = 'status_id' AND journal_details.property = 'attr' AND journal_details.value IN (SELECT is_close.id FROM issue_statuses is_close WHERE is_close.is_closed = 1) ORDER BY journals.created_on DESC LIMIT 1,1)"
          ) unless columns.detect{ |c| c.name == :closed_date }
        end
      end

      def self.included(klass)
        klass.send :alias_method_chain, :available_columns, :closed_date
      end
      
    end
  end
end
