namespace B2B_ORDERHISTORY;

//Entity table for the HANA db
entity B2B_OrderHistory {
    key shipTo            : String;
        hybrisOrderNumber : String;
        soldTo            : String(10);
    key erpOrderNumber    : String;
        poNumber          : String;
        paymentTerms      : String;
        orderType         : String;
        orderPlacedBy     : String;
        currency          : String;
        totalPrice        : Decimal(10, 2);
        erpOrderType      : String;
        orderStatus       : String;
        orderDate         : Timestamp;
        isSplitDelivery   : Boolean;
        subTotal          : Decimal(10, 2);
        freeShipping      : Boolean;
        holdCode          : String;
}

entity B2B_Consignments {
    key PickNumber      : String;
        invoicenum      : String;
        ContainerID     : String;
        TrackingNumber  : String;
        Carrier         : String;
        BillTo          : String(10);
        ShipTo          : String;
    key OrderType       : String;
    key OrderNumber     : String;
    key JDELineNumber   : String;
        ItemNumber      : String;
        Warehouse       : String;
        QuantityShipped : Decimal(10, 2);
        UnitPrice       : Decimal(10, 2);
        ExtendedPrice   : Decimal(10, 2);
        LastStat        : String;
        NextStat        : String;
        ShipDate        : Timestamp;
        ShipCarrier     : String;
        trackingUrl     : String;

}

entity B2B_Invoices {
        billtonum  : String(10);
        shiptonum  : String;
        invoiceco  : String;
    key invoicenum : String;
    key invoicetyp : String;
        reference  : String;
        ordernum   : String;
        ordertyp   : String;
        invdate    : Timestamp;
        duedate    : Timestamp;
        grossamt   : Decimal(15, 2);
        openamt    : Decimal(15, 2);
        indispute  : String;
        cc         : String;
        updateddat : Timestamp;

}
