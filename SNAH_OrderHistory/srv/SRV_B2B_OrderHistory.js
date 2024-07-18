const cds = require('@sap/cds');
const axios = require('axios').default;
const {
  getAccessToken
} = require('./SRV_B2B_TokenGenService');

const APICREDSOAUTHEADERS = (token) => ({
  "Authorization": `Bearer ${token}`,
  "Access-Control-Allow-Origin": "*"
});
//API URL for getting the total data from the hana cloud db table
const APIURL = "https://sna-common-dev-is-dev-snah-orderhistory-srv.cfapps.us20.hana.ondemand.com/odata/v4/erp-order-history/";
module.exports = cds.service.impl(async function (srv) {

  //Triggers when post call happen with payload
  this.on('POST', 'Payload', async (req) => {
    debugger;
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

    //quering the payload to get the requested data
    let query = '?$filter=';
    let subquery = '';
    if (soldTo && soldTo !== '') {
      query = (soldTo && soldTo !== '') ? `${query}soldTo eq '${soldTo}'` : query;
    }

    //orderStatus is an array, quering into query parameters
    if (status) {
      for (let i = 0; i < status.length; i++) {
        if (subquery === '') {
          subquery = `and orderStatus eq '${status[i]}'`;
        } else {
          subquery = (subquery && subquery !== '') ? `${subquery} or orderStatus eq '${status[i]}'` : subquery;
        }
      }
      if (subquery) {
        query = (query && query !== '') ? `${query} ${subquery}` : query;
      }
      subquery = '';
    }

    //orderType is an array, quering into the query parameters
    if (orderType) {
      for (let i = 0; i < orderType.length; i++) {
        if (subquery === '') {
          subquery = `and orderType eq '${orderType[i]}'`;
        } else {
          subquery = (subquery && subquery !== '') ? `${subquery} or orderType eq '${orderType[i]}'` : subquery;
        }
      }
      if (subquery) {
        query = (query && query !== '') ? `${query} ${subquery}` : query;
      }
      subquery = '';
    }

    //building the orderDate based on request as fromDate and toDate
    if (fromDate && toDate) {
      query = (query && query !== '') ? `${query} and orderDate ge ${fromDate} and orderDate le ${toDate}` : query;
    } else if (fromDate) {
      query = (query && query !== '') ? `${query} and orderDate eq ${fromDate}` : query;
    }

    //building the query based on the searchBy parameter with the search value
    if (searchBy) {
      switch (searchBy) {
        case 'orderNumber':
          query = (query && query !== '') ? `${query} and erpOrderNumber eq '${search}'` : query;
          break;
        case 'invoiceNumber':
          query = (query && query !== '') ? `${query} and invoiceNumber eq '${search}'` : query;
          break;
        case 'poNumber':
          query = (query && query !== '') ? `${query} and poNumber eq '${search}'` : query;
          break;
        case 'itemNumber':
          query = (query && query !== '') ? `${query} and itemNumber eq '${search}'` : query;
          break;
        default:
          query = (query && query !== '') ? `${query}` : query;
          break;
      }
    }
    if (currentPage >= 0) {
      query = (query && query !== '') ? `${query}&$skip=${currentPage}` : query;
    }
    if (pageSize >= 0) {
      query = (query && query !== '') ? `${query}&$top=${pageSize}` : query;
    }
    //quering for sorting the based on the sort parameters
    if (sort) {
      switch (sort) {
        case 'orderNumber':
          query = (query && query !== '') ? `${query}&$orderby=erpOrderNumber` : query;
          break;
        case 'orderStatus':
          query = (query && query !== '') ? `${query}&$orderby=orderStatus` : query;
          break;
        case 'orderType':
          query = (query && query !== '') ? `${query}&$orderby=orderType` : query;
          break;
        case 'poNumber':
          query = (query && query !== '') ? `${query}&$orderby=poNumber` : query;
          break;
        default:
          query = (query && query !== '') ? `${query}&$orderby=orderDate` : query;
          break;
      }
    }

    //setting the sort direction as asc or desc to the query
    if (dir) {
      query = (query && query !== '') ? `${query} ${dir}` : query;
    }
    console.log(query);

    //fetching the OrderHistory data
    const fetchOrderHistory = async () => {
      try {
        debugger;
        const accessToken = await getAccessToken(); //gets the access token
        const response = await axios.get(`${APIURL}OrderHistory${query}&$count=true&$format=JSON`, {
          headers: APICREDSOAUTHEADERS(accessToken)
        });
        if (response.data && response.data.value) {
          const orders = response.data.value.map(po => ({
            shipTo: po.shipTo,
            hybrisOrderNumber: po.hybrisOrderNumber,
            erpOrderNumber: po.erpOrderNumber,
            poNumber: po.poNumber,
            paymentTerms: po.paymentTerms,
            orderType: po.orderType,
            orderPlacedBy: po.orderPlacedBy,
            currency: po.currency,
            totalPrice: po.totalPrice,
            erpOrderType: po.erpOrderType,
            orderStatus: po.orderStatus,
            orderDate: po.orderDate
          }));
          const data = {
            orders,
            currentPage: currentPage,
            pageSize: pageSize,
            totalPages: Math.ceil(response.data["@odata.count"] / pageSize),
            totalResults: response.data["@odata.count"]
          };
          console.log(data);
          return data;
        } else {
          console.log(response.data);
          return {
            orders: [],
            currentPage,
            pageSize,
            totalPages: 0,
            totalResults: 0
          };
        }
      } catch (err) {
        debugger;
        console.error(err);
        if (err.response && err.response.data) {
          return {
            error: {
              code: err.response.data.code || 'ERROR_CODE',
              description: err.response.data.description || 'ERROR description'
            }
          };
        } else {
          return {
            error: {
              code: 'UNKNOWN_ERROR',
              description: 'An unknown error occurred'
            }
          };
        }
      }
    };
    return await fetchOrderHistory(); //returns the data
  });
});