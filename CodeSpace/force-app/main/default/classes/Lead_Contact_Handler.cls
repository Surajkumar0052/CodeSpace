// Whenever a new lead is created, create a new contact with last name as lead last name, first name as lead first name, phone as lead phone
// email as lead email

public class Lead_Contact_Handler {
    public static void create(List<Lead> leads){
        // Creating a list of contacts because we don't know how much leads will be created
        List<Contact> con = new List<Contact>();
        
        for(Lead l : leads){
            Contact c = new Contact();
            c.LastName = l.LastName;
            c.FirstName = l.FirstName;
            c.Phone = l.Phone;
            c.Email = l.Email;
            con.add(c);
            
        }
        
        insert con;
    }
}