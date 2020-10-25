namespace collab.api;

using cuid from '@sap/cds/common';

entity Companies:cuid{
    name:String;
}

entity Tasks : cuid{
    taskOrder:Integer;
    description:String;
    hours:Integer;
    task:String;
    company:Association to Companies
}

entity Users: cuid{
    name: String
}

entity UserTask:cuid{
    user:Association to Users;
    task: Association to Tasks;
    hoursCompleted: Integer;
    commentary:String;
}

entity Approvals:cuid{
    user:Association to Users;
    task: Association to Tasks
}