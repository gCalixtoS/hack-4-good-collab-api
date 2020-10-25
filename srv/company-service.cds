using collab.api as schema from '../db/data-model';

service CompanyService {
    entity Companies as projection on schema.Companies;
    entity Tasks as projection on schema.Tasks;
    entity Users as projection on schema.Users;
    entity UserTask as projection on schema.UserTask;
    @readonly view GetUserTask as select
        key UserTask.ID as UserTaskID,
        Tasks.taskOrder,
        Tasks.task,
        Tasks.hours,
        Tasks.description,
        SUM(UserTask.hoursCompleted) as hoursCompleted : Integer
        from Tasks join UserTask on Tasks.ID = UserTask.ID
        group by Tasks.ID, UserTask.user;
    @readonly view UnlockedTasks as select
        key Tasks.ID as taskID,
        Tasks.taskOrder,
        Tasks.task,
        Tasks.company.name as companyName,
        Tasks.company,
        case 
            when Tasks.taskOrder = 1 then 1 
            when Tasks.hours > ut.hoursCompleted then 1 
            else 0        
        end as taskApproved : Integer,
        ut.hoursCompleted : Integer,
        Tasks.hours,
        Tasks.description
        from Tasks left join (select UserTask.ID, SUM(UserTask.hoursCompleted) as hoursCompleted from UserTask group by UserTask.task) as ut on ut.ID = Tasks.ID group by Tasks.ID;
}
