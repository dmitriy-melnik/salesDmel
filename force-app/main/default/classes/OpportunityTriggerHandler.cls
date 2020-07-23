public with sharing class OpportunityTriggerHandler extends TriggerHandler {


    @TestVisible
    private static final String TASK_SUBJECT = 'Follow Up Closed Won';

    protected override void afterInsert() {
        this.countNumberOfOpportunities((List<Opportunity>)Trigger.new, null);
    }

    protected override void afterUpdate(){
        this.countNumberOfOpportunities((List<Opportunity>)Trigger.new, (Map<Id, Opportunity>)Trigger.oldMap);
    }

    protected override void afterDelete(){
        this.countNumberOfOpportunities(null, (Map<Id, Opportunity>)Trigger.oldMap);
    }

    protected override void afterUndelete(){
        this.countNumberOfOpportunities((List<Opportunity>)Trigger.new, null);
    }


    protected override void beforeInsert() {
        createTasks((List<Opportunity>) Trigger.new);
    }

    private static void createTasks(List<Opportunity> newList) {
        List<Task> taskList = new List<Task>();
        for(Opportunity opportunity : newList){
            if(opportunity.StageName.equals('Closed Won')){
                Task task = new Task(Subject = TASK_SUBJECT, WhatId = opportunity.Id);
                taskList.add(task);
            }
        }
        insert taskList;
    }

    private void countNumberOfOpportunities(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        Map<Id, Integer> accountIdToNumOfOpportunitiesMap = new Map<Id, Integer>();
        List<Account> accountsToUpdateList = new List<Account>();

        List<Opportunity> OpportunitiesToProcessList = (!Trigger.isDelete)
                ? newList
                : oldMap.values();

        for (Opportunity opportunity_i : OpportunitiesToProcessList) {
            if ((Trigger.isInsert || Trigger.isDelete || Trigger.isUndelete) && opportunity_i.AccountId != null) {
                accountIdToNumOfOpportunitiesMap.put(opportunity_i.AccountId, 0);
            }

            if (Trigger.isUpdate && opportunity_i.AccountId != oldMap.get(opportunity_i.Id).AccountId) {
                accountIdToNumOfOpportunitiesMap.put(opportunity_i.AccountId, 0);
                if (oldMap.get(opportunity_i.Id).AccountId != null) {
                    accountIdToNumOfOpportunitiesMap.put(oldMap.get(opportunity_i.Id).AccountId, 0);
                }
            }
        }
        if (accountIdToNumOfOpportunitiesMap.isEmpty()) {
            return;
        }

        List<AggregateResult> aggResList = [
                SELECT COUNT(Id) opportunitiesCount, AccountId
                FROM Opportunity
                WHERE AccountId IN: accountIdToNumOfOpportunitiesMap.keySet()
                GROUP BY AccountId
        ];

        if (!aggResList.isEmpty()) {
            for (AggregateResult result_i : aggResList) {
                if (accountIdToNumOfOpportunitiesMap.containsKey((Id)result_i.get('AccountId'))) {
                    accountIdToNumOfOpportunitiesMap.put((Id)result_i.get('AccountId'), (Integer)result_i.get('opportunitiesCount'));
                }
            }
        }

        for (Id accountId_i : accountIdToNumOfOpportunitiesMap.keySet()) {

            accountsToUpdateList.add(
                    new Account(
                            Id = accountId_i,
                            Count_Of_Opportunities__c = accountIdToNumOfOpportunitiesMap.get(accountId_i)
                    )
            );
        }
        update accountsToUpdateList;

    }



}