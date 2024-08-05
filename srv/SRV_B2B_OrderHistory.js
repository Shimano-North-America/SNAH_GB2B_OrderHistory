const cds = require('@sap/cds');
const axios = require('axios').default;

module.exports = cds.service.impl(async function (srv) {
    const db = await cds.connect.to("db");
    const {
        B2B_OrderHistory,
        B2B_Consignments,
        B2B_Invoices
    } = db.entities;
    //Triggers when the Payload post call happen to the endpoint
    this.on('POST', 'GetOrderHistory', async (req) => {
        //initializing the req data into the respected fields to quering
        const {
            soldTo,
            search,
            searchBy,
            fromDate,
            toDate,
            status,
            orderType,
            sort,
            dir,
            currentPage,
            pageSize
        } = req.data || {};
        debugger;
        try {
            // Initial query to get all matching results from the db
            let query = SELECT.from(B2B_OrderHistory)
                .columns(
                    'shipTo', 'hybrisOrderNumber', 'soldTo', 'erpOrderNumber',
                    'poNumber', 'paymentTerms', 'orderType', 'orderPlacedBy',
                    'currency', 'totalPrice', 'erpOrderType', 'orderStatus', 'orderDate'
                )
                .where({
                    soldTo: soldTo
                });
            //adding the fromDate and toDate based on payload data sent
            if (fromDate && toDate) {
                query.where({
                    orderDate: {
                        between: fromDate,
                        and: toDate
                    }
                });
            } else if (fromDate && !toDate) {
                query.where({
                    orderDate: {
                        '=': fromDate
                    }
                });
            }
            // Adding the orderStatus to the query 
            if (status && status.length > 0) {
                query.where({
                    orderStatus: {
                        in: status
                    }
                });
            }
            // Adding orderType to the query
            if (orderType && orderType.length > 0) {
                query.where({
                    orderType: {
                        in: orderType
                    }
                });
            }
            // Adding the Search condition based on the SearchBy parameter
            if (search && searchBy) {
                let searchColumn = searchBy;
                if (searchBy === "orderNumber") {
                    searchColumn = "ERPORDERNUMBER";
                };
                query.where({
                    [searchColumn]: {
                        like: `%${search}%`
                    }
                });
            };
            // Adding the sort condition based on the direction
            let sortColumn = sort;
            if (sort === "orderNumber") {
                sortColumn = "ERPORDERNUMBER";
            };
            query.orderBy(`${sortColumn} ${dir}`);

            //get the total results from the db based on query
            const result = await cds.run(query);
            const totalResults = result.length;
            if (totalResults === 0) {
                req.reject(403, "Data Not Found");
            };
            debugger;
            // Calculating the total pages retrieved
            const totalPages = Math.ceil(totalResults / pageSize);

            // Calculating start and end index for pagination of the pageSize and currentPage
            const startIndex = currentPage * pageSize;
            const endIndex = startIndex + pageSize;
            // Slicing the results to get only the currentPage records for the response
            const paginatedResults = result.slice(startIndex, endIndex);

            // Mapping the results for the response
            const orders = paginatedResults.map(order => ({
                shipTo: order.shipTo,
                hybrisOrderNumber: order.hybrisOrderNumber,
                erpOrderNumber: order.erpOrderNumber,
                poNumber: order.poNumber,
                paymentTerms: order.paymentTerms,
                orderType: order.orderType,
                orderPlacedBy: order.orderPlacedBy,
                currency: order.currency,
                erpOrderType: order.erpOrderType,
                orderStatus: order.orderStatus,
                orderDate: order.orderDate,
                totalPrice: order.totalPrice
            }));
            //Building the return data 
            let data = {
                orders,
                currentPage: Number(currentPage),
                pageSize: Number(pageSize),
                totalPages: totalPages,
                totalResults: totalResults
            };
            //Returning the response
            return data;
        } catch (err) {
            console.error(err);
            //if catches any error returning that error
            req.reject(err.code, err.message || "An unexpected error occurred");
        }
    });
    //Triggers when the GetOrderStatus post call happen to the endpoint
    this.on('POST', 'GetOrderStatus', async (req) => {
        const {
            soldTo,
            erpOrderNumber,
            erpOrderType
        } = req.data || {};
        debugger;
        try {
            let OrderHistory = SELECT.from(B2B_OrderHistory).where({
                soldTo: soldTo,
                erpOrderNumber: erpOrderNumber,
                erpOrderType: erpOrderType
            });

            let Consignments = SELECT.from(B2B_Consignments).where({
                BillTo: soldTo,
                OrderNumber: erpOrderNumber,
                OrderType: erpOrderType
            });
            let Invoice = SELECT.from(B2B_Invoices).where({
                billtonum: soldTo,
                ordernum: erpOrderNumber,
                ordertyp: erpOrderType
            });
            const OrderHistory_res = await cds.run(OrderHistory);
            const Consignments_res = await cds.run(Consignments);
            const Invoice_res = await cds.run(Invoice);
            debugger;
            // Check if all the arrays are empty
            if (OrderHistory_res.length === 0 && Consignments_res.length === 0 && Invoice_res.length === 0) {
                req.reject(403, "Data Not Found");
            };
            const orderHistory = OrderHistory_res.map(order => ({
                shipTo: order.shipTo,
                soldTo: order.soldTo,
                hybrisOrderNumber: order.hybrisOrderNumber,
                paymentTerms: order.paymentTerms,
                poNumber: order.poNumber,
                orderType: order.orderType,
                orderPlacedBy: order.orderPlacedBy,
                isSplitDelivery: order.isSplitDelivery,
                currency: order.currency,
                totalPrice: order.totalPrice,
                subTotal: order.subTotal,
                erpOrderNumber: order.erpOrderNumber,
                orderStatus: order.orderStatus,
                orderDate: order.orderDate,
                holdCode: order.holdCode,
                freeShipping: order.freeShipping
            }));
            const consignments = Consignments_res.map(Consign => ({
                PickNumber: Consign.PickNumber,
                invoicenum: Consign.invoicenum,
                ContainerID: Consign.ContainerID,
                Carrier: Consign.Carrier,
                BillTo: Consign.BillTo,
                ShipTo: Consign.ShipTo,
                OrderType: Consign.OrderType,
                OrderNumber: Consign.OrderNumber,
                JDELineNumber: Consign.JDELineNumber,
                ItemNumber: Consign.ItemNumber,
                Warehouse: Consign.Warehouse,
                QuantityShipped: Consign.QuantityShipped,
                UnitPrice: Consign.UnitPrice,
                ExtendedPrice: Consign.ExtendedPrice,
                LastStat: Consign.LastStat,
                NextStat: Consign.NextStat,
                ShipDate: Consign.ShipDate,
                ShipCarrier: Consign.ShipCarrier,
                trackAndTrace: {
                    TrackingNumber: Consign.TrackingNumber,
                    trackingLink: Consign.trackingUrl
                }
            }));
            const invoice = Invoice_res.map(invoice => ({
                billtonum: invoice.billtonum,
                shiptonum: invoice.shiptonum,
                invoiceco: invoice.invoiceco,
                invoicenum: invoice.invoicenum,
                invoicetyp: invoice.invoicetyp,
                reference: invoice.reference,
                ordernum: invoice.ordernum,
                ordertyp: invoice.ordertyp,
                invdate: invoice.invdate,
                duedate: invoice.duedate,
                grossamt: invoice.grossamt,
                openamt: invoice.openamt,
                indispute: invoice.indispute,
                cc: invoice.cc,
                updateddat: invoice.updateddat
            }));
            // Check if all the arrays are empty
            if (orderHistory.length === 0 && consignments.length === 0 && invoice.length === 0) {
                req.reject(403, "Data Not Found");
            };
            let data = {
                orderHistory: orderHistory,
                consignments,
                invoice
            };
            return data;
        } catch (err) {
            console.error(err);
            return {
                error: {
                    code: err.code || "ERROR_CODE",
                    description: err.message || "An unexpected error occurred"
                }
            };
        }
    });
});