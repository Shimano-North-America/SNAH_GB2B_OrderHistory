namespace B2B_ORDERHISTORY;

entity B2B_OrderHistory {
    key shipTo            : String(10)
        @Core.Description: 'Ship To';
    key erpOrderNumber    : String(10)
        @Core.Description: 'ERP Order Number';
        hybrisOrderNumber : String(10)
        @Core.Description: 'Hybris Order Number';
        soldTo            : String(10)
        @Core.Description: 'Sold To';
        poNumber          : String
        @Core.Description: 'PO Number';
        paymentTerms      : String
        @Core.Description: 'Payment Terms';
        orderType         : String
        @Core.Description: 'Order Types';
        orderPlacedBy     : String
        @Core.Description: 'Order Placed By';
        currency          : String
        @Core.Description: 'Currency';
        totalPrice        : Decimal(10, 2)
        @Core.Description: 'Total Price';
        erpOrderType      : String
        @Core.Description: 'ERP Order Type';
        orderStatus       : String
        @Core.Description: 'Order Status';
        orderDate         : Timestamp
        @Core.Description: 'Order Date';
        isSplitDelivery   : Boolean
        @Core.Description: 'Is Split Delivery';
        subTotal          : Decimal(10, 2)
        @Core.Description: 'Sub Total';
        freeShipping      : Boolean
        @Core.Description: 'Free Shipping';
        holdCode          : String
        @Core.Description: 'Hold Code';
}

entity B2B_Consignments {
    key PickNumber      : String
        @Core.Description: 'Pick Number';
        invoicenum      : String
        @Core.Description: 'Invoice Number';
        ContainerID     : String
        @Core.Description: 'Container ID';
        TrackingNumber  : String
        @Core.Description: 'Tracking Number';
        Carrier         : String
        @Core.Description: 'Carrier';
        BillTo          : String(10)
        @Core.Description: 'Bill To';
        ShipTo          : String(10)
        @Core.Description: 'Ship To';
    key OrderType       : String
        @Core.Description: 'Order Type';
    key OrderNumber     : String
        @Core.Description: 'Order Number';
    key JDELineNumber   : String
        @Core.Description: 'JDE Line Number';
        ItemNumber      : String
        @Core.Description: 'Item Number';
        Warehouse       : String
        @Core.Description: 'Ware House';
        QuantityShipped : Decimal(10, 2)
        @Core.Description: 'Quantity Shipped';
        UnitPrice       : Decimal(10, 2)
        @Core.Description: 'Unit Price';
        ExtendedPrice   : Decimal(10, 2)
        @Core.Description: 'Extended Price';
        LastStat        : String
        @Core.Description: 'Last Status';
        NextStat        : String
        @Core.Description: 'Next Status';
        ShipDate        : Timestamp
        @Core.Description: 'Ship Date';
        ShipCarrier     : String
        @Core.Description: 'Ship Carrier';
        trackingUrl     : String
        @Core.Description: 'Tracking URL';
}

entity B2B_Invoices {
        billtonum  : String(10)
        @Core.Description: 'Bill To Number';
        shiptonum  : String
        @Core.Description: 'Ship To Number';
        invoiceco  : String
        @Core.Description: 'Invoice CO';
    key invoicenum : String
        @Core.Description: 'Invoice Number';
    key invoicetyp : String
        @Core.Description: 'Invoice Type';
        reference  : String
        @Core.Description: 'Reference';
        ordernum   : String
        @Core.Description: 'Order Number';
        ordertyp   : String
        @Core.Description: 'Order Type';
        invdate    : Timestamp
        @Core.Description: 'Invoice Date';
        duedate    : Timestamp
        @Core.Description: 'Due Date';
        grossamt   : Decimal(15, 2)
        @Core.Description: 'Gross Amount';
        openamt    : Decimal(15, 2)
        @Core.Description: 'Open Amount';
        indispute  : String
        @Core.Description: 'Indispute';
        cc         : String
        @Core.Description: 'CC';
        updateddat : Timestamp
        @Core.Description: 'Updated Date';
}
