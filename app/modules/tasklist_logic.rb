module Tasklist_logic 
    def getList()
        TTaskPlanHeader.includes(:task_plan_lists)
    end

    def getresult()

    end


    def addplan()
    end

    def setplan()

    end 

    def setresult(resultdata)
        
    end

    module_function :getList
end

