namespace orderhistory;

entity B2B_OrderHistory {
    key shipTo            : String;
    key hybrisOrderNumber : String;
        soldTo            : String;
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
    key shipTo         : String;
        status         : String;
        deliveryDate   : Timestamp;
        trackingNumber : String;
        totalPrice     : Decimal(10, 2);
}

entity B2B_Invoices {
    key referenceNumber : String;
        date            : Timestamp;
        paymentStatus   : String;

}
