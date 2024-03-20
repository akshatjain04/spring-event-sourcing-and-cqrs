// ********RoostGPT********
/*
Test generated by RoostGPT for test spring-event-sourcing-and-cqrs-test using AI Type Azure Open AI and AI Model roostgpt-4-32k

ROOST_METHOD_HASH=equals_3174cdbf14
ROOST_METHOD_SIG_HASH=equals_04d0b28fc6

================================VULNERABILITIES================================
Vulnerability: Information Disclosure
Issue: The 'equals' method can throw a ClassCastException if it's used with an incompatible type, which may disclose information about the application's internal workings.
Solution: We can protect against this by adding an explicit check for class type before casting.

Vulnerability: DoS Attacks and Performance Management
Issue: The 'equals' method might be expensive if used intensively, leading to potential performance issues. Overuse might end up with denial of service attack.
Solution: Consider reviewing uses of the 'equals' function and limit usage to where it is absolutely necessary.

================================================================================
Scenario 1: Test for object equality with the same object instance

Details:  
  TestName: testEqualWithSameInstance
  Description: The test checks if the equals method returns true when the object is being compared with the same instance.
  Execution:
    Arrange: Create a LeadCreated object instance.
    Act: Call equals method and compare the object with itself.
    Assert: Assert that equals method returns true. 
  Validation: 
    The equals method should return true when a comparison is made with the same object instance which validates object identity.

Scenario 2: Test for object equality with a null object

Details:  
  TestName: testEqualsWithNullObject
  Description: This test checks if the equals method correctly returns false when the object is compared with a null reference.
  Execution:
    Arrange: Create a LeadCreated object instance.
    Act: Call equals method and compare the object with a null object.
    Assert: Assert that equals method returns false.
  Validation: 
    The equals method should return false when compared with a null object which validates the handling of null objects.

Scenario 3: Test for object equality with a different class instance

Details:  
  TestName: testEqualsWithDifferentClassInstance
  Description: This test checks if the equals method returns false when the object is compared with an instance of a different class.
  Execution:
    Arrange: Create a LeadCreated object and UUID object instance.
    Act: Call equals method and compare the LeadCreated object with the UUID instance.
    Assert: Assert that equals method returns false.
  Validation: 
    The equals method should return false when compared with an instance of a different class which validates type safety handling in equality.

Scenario 4: Test for objects equality with same leadId and name

Details:  
  TestName: testEqualObjectsWithSameLeadIdAndName
  Description: This test checks if the equals method returns true when the object is compared with another object with the same leadId and name.
  Execution:
    Arrange: Create two LeadCreated object instances with the same leadId and name.
    Act: Call equals method and compare the two objects.
    Assert: Assert that equals method returns true.
  Validation: 
    The equals method should return true when compared with an object with the same leadId and name, validating the equality based on state and not identity.

Scenario 5: Test object equality with different leadIds or names

Details:
  TestName: testUnequalObjectsWithDifferentLeadIdOrName
  Description: This test checks if the equals method returns false when the object is compared with another object with either a different leadId or name.
  Execution:
    Arrange: Create two LeadCreated object instances, one with a different leadId or name.
    Act: Call equals method and compare the two objects.
    Assert: Assert that equals method returns false.
  Validation: 
    The equals method should return false when compared with an object with a different leadId or name, validating its functionality in handling differing object states.
*/

// ********RoostGPT********
package com.baeldung.store.events;

import java.util.UUID;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class LeadCreatedEqualsTest {

    @Test
    public void testEqualWithSameInstance() {
        UUID uuid = UUID.randomUUID();
        String name = "TestLead";
        LeadCreated leadCreated = new LeadCreated(uuid, uuid, name);

        Assertions.assertTrue(leadCreated.equals(leadCreated)); 
    }

    @Test
    public void testEqualsWithNullObject() {
        UUID uuid = UUID.randomUUID();
        String name = "TestLead";
        LeadCreated leadCreated = new LeadCreated(uuid, uuid, name);

        Assertions.assertFalse(leadCreated.equals(null)); 
    }

    @Test
    public void testEqualsWithDifferentClassInstance() {
        UUID uuid = UUID.randomUUID();
        String name = "TestLead";
        LeadCreated leadCreated = new LeadCreated(uuid, uuid, name);

        Assertions.assertFalse(leadCreated.equals(uuid)); 
    }

    @Test
    public void testEqualObjectsWithSameLeadIdAndName() {
        UUID uuid = UUID.randomUUID();
        String name = "TestLead";
        LeadCreated leadCreated1 = new LeadCreated(uuid, uuid, name);
        LeadCreated leadCreated2 = new LeadCreated(uuid, uuid, name);

        Assertions.assertTrue(leadCreated1.equals(leadCreated2)); 
    }

    @Test
    public void testUnequalObjectsWithDifferentLeadIdOrName() {
        UUID uuid = UUID.randomUUID();
        String name1 = "TestLead1";
        String name2 = "TestLead2";
        LeadCreated leadCreated1 = new LeadCreated(uuid, uuid, name1);
        LeadCreated leadCreated2 = new LeadCreated(uuid, uuid, name2);

        Assertions.assertFalse(leadCreated1.equals(leadCreated2)); 
    } 
}
