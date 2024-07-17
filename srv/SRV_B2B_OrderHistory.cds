// using B2B_ORDERHISTORY as B2B from '../db/Schema_B2B_OrderHistory';

service ERP_Order_History {
    // entity OrderHistory as projection on B2B.B2B_OrderHistory;
    @cds.persistence.skip
    entity GetOrderHistory {
        orders       : array of {
            shipTo            : String
            @Core.Description: 'Ship To';
            hybrisOrderNumber : String
            @Core.Description: 'Hybris Order Number';
            erpOrderNumber    : String
            @Core.Description: 'ERP Order Number';
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
            erpOrderType      : String
            @Core.Description: 'ERP Order Type';
            orderStatus       : String
            @Core.Description: 'Order Status';
            orderDate         : Timestamp
            @Core.Description: 'Order Date';
            totalPrice        : Decimal(10, 2)
            @Core.Description: 'Total Price';
        };
        soldTo       : String(10)
            @Core.Description: 'Sold To';
        search       : String
            @Core.Description: 'Search';
        searchBy     : String
            @Core.Description: 'Search By';
        fromDate     : String
            @Core.Description: 'From Date';
        toDate       : String
            @Core.Description: 'To Date';
        status       : array of String
            @Core.Description: 'Order Status';
        sort         : String
            @Core.Description: 'Sort';
        dir          : String
            @Core.Description: 'Sort Direction';
        currentPage  : Integer
            @Core.Description: 'Current Page';
        pageSize     : Integer
            @Core.Description: 'Page Size';
        orderType    : array of String
            @Core.Description: 'Order Type';
        totalPages   : String
            @Core.Description: 'Total Pages';
        totalResults : String
            @Core.Description: 'Total Results';
    }

    //Get Order Status Implementation
    @cds.persistence.skip
    entity GetOrderStatus {
        soldTo         : String(10)
                @Core.Description: 'Sold To';
        erpOrderNumber : String
                @Core.Description: 'ERP Order Number';
        erpOrderType   : String
                @Core.Description: 'ERP Order Type';
        orderHistory   : array of {
            shipTo             : String
                @Core.Description: 'Ship To';
            hybrisOrderNumber  : String
                @Core.Description: 'Hybris Order Number';
            soldTo             : String
                @Core.Description: 'Sold To';
            erpOrderNumber     : String
                @Core.Description: 'ERP Order Number';
            poNumber           : String
                @Core.Description: 'PO Number';
            paymentTerms       : String
                @Core.Description: 'Payment Terms';
            orderType          : String
                @Core.Description: 'Order Type';
            orderPlacedBy      : String
                @Core.Description: 'Order Placed By';
            currency           : String
                @Core.Description: 'Currency';
            totalPrice         : Decimal(10, 2)
                @Core.Description: 'total Price';
            erpOrderType       : String
                @Core.Description: 'ERP Order Type';
            orderStatus        : String
                @Core.Description: 'Order Status';
            orderDate          : Timestamp
                @Core.Description: 'Order Date';
            isSplitDelivery    : Boolean
                @Core.Description: 'Is Splite Delivery';
            subTotal           : Decimal(10, 2)
                @Core.Description: 'Sub Total';
            discount           : Decimal(10, 2)
                @Core.Description: 'Discount';
            deliveryFee        : Decimal(10, 2)
                @Core.Description: 'Delivery Fee';
            changesPending     : Boolean
                @Core.Description: 'Changes Pending';
            editable           : Boolean
                @Core.Description: 'Editable';
            freeShipping       : Boolean
                @Core.Description: 'Free Shipping';
            holdCode           : String
                @Core.Description: 'Hold Code';
        };

        consignments   : array of {
            PickNumber         : String
                @Core.Description: 'Pick Number';
            invoicenum         : String
                @Core.Description: 'Invoice Number';
            ContainerID        : String
                @Core.Description: 'Container ID';
            TrackingNumber     : String
                @Core.Description: 'Tracking Number';
            Carrier            : String
                @Core.Description: 'Carrier';
            BillTo             : String(10)
                @Core.Description: 'Bill To';
            ShipTo             : String
                @Core.Description: 'Ship To';
            OrderType          : String
                @Core.Description: 'Order Type';
            OrderNumber        : String
                @Core.Description: 'Order Number';
            JDELineNumber      : String
                @Core.Description: 'JDE Line Number';
            ItemNumber         : String
                @Core.Description: 'Item Number';
            Warehouse          : String
                @Core.Description: 'Ware House';
            QuantityShipped    : Decimal(10, 2)
                @Core.Description: 'Quantity Shipped';
            UnitPrice          : Decimal(10, 2)
                @Core.Description: 'Unit Price';
            ExtendedPrice      : Decimal(10, 2)
                @Core.Description: 'Extended Price';
            totalPrice         : Decimal(10, 2)
                @Core.Description: 'Total Price';
            deliveryDate       : Timestamp
                @Core.Description: 'Delivery Date';
            LastStat           : String
                @Core.Description: 'Last Status';
            NextStat           : String
                @Core.Description: 'Next Status';
            ShipDate           : Timestamp
                @Core.Description: 'Ship Date';
            ShipCarrier        : String
                @Core.Description: 'Ship Carrier';
            status             : String
                @Core.Description: 'Status';
            trackAndTrace      : {
                TrackingNumber : String
                @Core.Description: 'Tracking Number';
                trackingLink   : String
                @Core.Description: 'Tracking Link';
            };
        };
        entries        : array of {
            hybrisLineNumber   : String
                @Core.Description: 'Hybris Line Number';
            productCode        : String
                @Core.Description: 'Product Code';
            dealerPrice        : String
                @Core.Description: 'Dealer Price';
            quantity           : String
                @Core.Description: 'Quantity';
            totalPrice         : Decimal(10, 2)
                @Core.Description: 'Total Price';
            erpLineNumber      : String
                @Core.Description: 'ERP Line Number';
            changesPending     : Boolean
                @Core.Description: 'Changes Pending';
            holdCode           : String
                @Core.Description: 'Hold Code';
        };
        invoice        : array of {
            billtonum          : String(10)
                @Core.Description: 'Bill To Number';
            shiptonum          : String
                @Core.Description: 'Ship To Number';
            invoiceco          : String
                @Core.Description: 'Invoice CO';
            invoicenum         : String
                @Core.Description: 'Invoice Number';
            invoicetyp         : String
                @Core.Description: 'Invoice Type';
            referenceNumber    : String
                @Core.Description: 'Reference Number';
            downloadLink       : String
                @Core.Description: 'Download Link';
            date               : Timestamp
                @Core.Description: 'Date';
            paymentStatus      : String
                @Core.Description: 'Payment Status';
            ordernum           : String
                @Core.Description: 'Order Number';
            ordertyp           : String
                @Core.Description: 'Order Type';
            invdate            : Timestamp
                @Core.Description: 'Invoice Date';
            duedate            : Timestamp
                @Core.Description: 'Due Date';
            grossamt           : Decimal(15, 2)
                @Core.Description: 'Gross Amount';
            openamt            : Decimal(15, 2)
                @Core.Description: 'Open Amount';
            indispute          : String
                @Core.Description: 'Indispute';
            cc                 : String
                @Core.Description: 'CC';
            updateddat         : Timestamp
                @Core.Description: 'Updated Date';
        };
    }
}
