// using B2B_ORDERHISTORY as B2B from '../db/Schema_B2B_OrderHistory';

service ERP_Order_History {
    // entity OrderHistory as projection on B2B.B2B_OrderHistory;
    @cds.persistence.skip
    entity GetOrderHistory {
        orders       : array of {
            shipTo            : String;
            hybrisOrderNumber : String;
            erpOrderNumber    : String;
            poNumber          : String;
            paymentTerms      : String;
            orderType         : String;
            orderPlacedBy     : String;
            currency          : String;
            erpOrderType      : String;
            orderStatus       : String;
            orderDate         : Timestamp;
            totalPrice        : Decimal(10, 2);
        };
        soldTo       : String;
        search       : String;
        searchBy     : String;
        fromDate     : String;
        toDate       : String;
        status       : array of String;
        sort         : String;
        dir          : String;
        currentPage  : Integer;
        pageSize     : Integer;
        orderType    : array of String;
        totalPages   : String;
        totalResults : String;
    }

    //Get Order Status Implementation
    @cds.persistence.skip
    entity GetOrderStatus {
        soldTo         : String;
        erpOrderNumber : String;
        erpOrderType   : String;
        orderHistory   : array of {
            shipTo             : String;
            hybrisOrderNumber  : String;
            soldTo             : String;
            erpOrderNumber     : String;
            poNumber           : String;
            paymentTerms       : String;
            orderType          : String;
            orderPlacedBy      : String;
            currency           : String;
            totalPrice         : Decimal(10, 2);
            erpOrderType       : String;
            orderStatus        : String;
            orderDate          : Timestamp;
            isSplitDelivery    : Boolean;
            subTotal           : Decimal(10, 2);
            discount           : Decimal(10, 2);
            deliveryFee        : Decimal(10, 2);
            changesPending     : Boolean;
            editable           : Boolean;
            freeShipping       : Boolean;
            holdCode           : String;
        };

        consignments   : array of {
            PickNumber         : String;
            invoicenum         : String;
            ContainerID        : String;
            TrackingNumber     : String;
            Carrier            : String;
            BillTo             : String;
            ShipTo             : String;
            OrderType          : String;
            OrderNumber        : String;
            JDELineNumber      : String;
            ItemNumber         : String;
            Warehouse          : String;
            QuantityShipped    : Decimal(10, 2);
            UnitPrice          : Decimal(10, 2);
            ExtendedPrice      : Decimal(10, 2);
            totalPrice         : Decimal(10, 2);
            deliveryDate       : Timestamp;
            LastStat           : String;
            NextStat           : String;
            ShipDate           : Timestamp;
            ShipCarrier        : String;
            status             : String;
            trackAndTrace      : {
                TrackingNumber : String;
                trackingLink   : String;
            };
        };
        entries        : array of {
            hybrisLineNumber   : String;
            productCode        : String;
            dealerPrice        : String;
            quantity           : String;
            totalPrice         : Decimal(10, 2);
            erpLineNumber      : String;
            changesPending     : Boolean;
            holdCode           : String;
        };
        invoice        : array of {
            billtonum          : String;
            shiptonum          : String;
            invoiceco          : String;
            invoicenum         : String;
            invoicetyp         : String;
            referenceNumber    : String;
            downloadLink       : String;
            date               : Timestamp;
            paymentStatus      : String;
            ordernum           : String;
            ordertyp           : String;
            invdate            : Timestamp;
            duedate            : Timestamp;
            grossamt           : Decimal(15, 2);
            openamt            : Decimal(15, 2);
            indispute          : String;
            cc                 : String;
            updateddat         : Timestamp;
        };
    }
}
