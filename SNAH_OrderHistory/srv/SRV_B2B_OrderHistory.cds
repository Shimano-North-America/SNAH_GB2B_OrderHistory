using orderhistory from '../db/Schema_B2B_OrderHistory';

service ERP_Order_History {
    entity OrderHistory as projection on orderhistory.B2B_OrderHistory;
    // entity Payload      as projection on orderhistory.Payload;

    entity Payload {
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
        fromDate     : Timestamp;
        toDate       : Timestamp;
        status       : array of String;
        sort         : String;
        dir          : String;
        currentPage  : Integer;
        pageSize     : Integer;
        orderType    : array of String;
        totalPages   : String;
        totalResults : String;
    }

}
