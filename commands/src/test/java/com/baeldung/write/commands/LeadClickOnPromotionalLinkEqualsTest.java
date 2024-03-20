package com.baeldung.write.commands;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class LeadClickOnPromotionalLinkEqualsTest {
    private LeadClickOnPromotionalLink leadClickOnPromotionalLink1;
    private LeadClickOnPromotionalLink leadClickOnPromotionalLink2;
    private LeadClickOnPromotionalLink leadClickOnPromotionalLink3;
    private Object obj;

    @BeforeEach
    public void setUp() {
        leadClickOnPromotionalLink1 = new LeadClickOnPromotionalLink();
        leadClickOnPromotionalLink2 = new LeadClickOnPromotionalLink();
        leadClickOnPromotionalLink3 = new LeadClickOnPromotionalLink();
        obj = new Object();
    }

    @Test
    public void testEqualsWithSelf() {
        assertEquals(leadClickOnPromotionalLink1, leadClickOnPromotionalLink1);
    }

    @Test
    public void testEqualsWithNull() {
        assertNotEquals(leadClickOnPromotionalLink1, null);
    }

    @Test
    public void testEqualsWithDifferentClass() {
        assertNotEquals(leadClickOnPromotionalLink1, obj);
    }

    @Test
    public void testEqualsWithSameId() {
        UUID uuid = UUID.randomUUID();
        leadClickOnPromotionalLink2.setIdOfLead(uuid);
        leadClickOnPromotionalLink3.setIdOfLead(uuid);
        assertEquals(leadClickOnPromotionalLink2, leadClickOnPromotionalLink3);
    }

    @Test
    public void testEqualsWithDifferentId() {
        leadClickOnPromotionalLink2.setIdOfLead(UUID.randomUUID());
        leadClickOnPromotionalLink3.setIdOfLead(UUID.randomUUID());
        assertNotEquals(leadClickOnPromotionalLink2, leadClickOnPromotionalLink3);
    }
}
