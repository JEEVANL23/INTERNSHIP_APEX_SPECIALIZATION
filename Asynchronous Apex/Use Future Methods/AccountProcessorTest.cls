@IsTest
public class AccountProcessor {
	@future
	public static void countContacts (List<Id> accountIds) {
			List<Account> accountsToUpdate = new List<Account>();
			List<Account> accounts = [Select Id, Name, (Select Id from Contacts) from Account Where Id in :accountIds];
			For (Account acc:accounts) {
			List<Contact> contactList = acc.Contacts;
			acc.Number_Of_Contacts__c = contactList.size();
			accountsToUpdate.add(acc);
				}
						update accountsToUpdate;
				}
}{

    	@IsTest
    private static void testCountContacts(){
        	Account newAccount = new Account(Name = 'Test Account');
        	insert newAccount;
        
        	Contact newContact1= new Contact(FirstName='John', LastName='Doe', AccountId = newAccount.Id);
        	insert newContact1;
        
        	Contact newContact2= new Contact(FirstName='Johnnn', LastName='Doe', AccountId = newAccount.Id);
        	insert newContact2;
        
        	List<Id> accountIds = new List<Id>();
        	accountIds.add(newAccount.Id);
        
        	Test.startTest();
        	AccountProcessor.countContacts(accountIds);
        	Test.stopTest();
        
    }
}
