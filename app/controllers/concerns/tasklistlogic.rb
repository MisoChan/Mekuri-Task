

module Tasklistlogic
    extend ActiveSupport::Concern

    def getlist()
        TTaskPlanHeader.includes(:task_plan_lists)
    end


    def addplan()
    end

    def setplan()

    end 

    def setresult(resultdata)
        
    end
    
    
end
