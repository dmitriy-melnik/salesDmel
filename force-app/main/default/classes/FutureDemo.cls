/**
 * Created by Manlik on 25.06.2020.
 */

public class FutureDemo {
    @future
    public static void someFutureMethod(Set<Id> accountIdSet) {
        List<Account> accounts = [Select Id, Name from Account Where Id IN :accountIdSet];
        // process account records to do awesome stuff

        for (Account account_i : accounts) {
            account_i.Phone = '12345678';
        }

        update accounts;
    }
}