

module TasklistControllable
    extend ActiveSupport::Concern

    def getlist()
        TTaskPlanHeader.includes(:task_plan_lists)
    end


    def addplan()
        TTaskPlanHeader.set
    end

    def setplan()

    end 

    def setresult(resultdata)
        
    end
    
    
end
