public class DMLpractice {
    public static void createData(){
        List<SObject> sobjList = new List<SObject>();
        Account acc = new Account(Name='Ritik', Rating='Warm');
        sobjList.add(acc);
        Contact con = new Contact(LastName='Tiwari', AccountId=acc.Id);
        sobjList.add(con);
        acc.Name = 'Gaurav';
        upsert sobjList;
        System.debug('Account inserted/updated : ' + sobjList);
        delete sobjList;
    }
}