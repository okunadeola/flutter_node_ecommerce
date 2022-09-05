



// ignore_for_file: avoid_print


import 'package:ecom/constants/constants.dart';
import 'package:ecom/constants/responsive.dart';
import 'package:ecom/features/admin/screens/add_product_screen.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';


class Paging extends StatefulWidget {
  const Paging({Key? key}) : super(key: key);

  @override
  State<Paging> createState() => _PagingState();
}

class _PagingState extends State<Paging> {
List<Product> products = [];
int totalPage = 1;
int selectedPage = 1;
  var _sortIndex = 0;
  var _sortAsc = true;



// var _show = false;
// final search = 'ola';
// List _info = [];
  // var selectedPageNumber = 3;

  // final DataTableSource _data = MyData();

    void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });

  @override
  void initState() {
      // handlePage(1);
    super.initState();

    fetchAllProducts(1);
  }

  fetchAllProducts(int page) async {
    if (mounted) {
      var res = await AdminServices().fetchAllProductsWithPagination(context, page);
      products = res['products'];
      totalPage = res['totalPage'];
      setState(() {});
    }
  }


  handlePageChanged(int ? data)async{
        final currentPage = data ?? 1;
        await fetchAllProducts(currentPage);
  }

//  fetchUser(currrentPage)async{
//     if(currrentPage <= 100){
//       try {
//           final url = Uri.parse('https://api.github.com/search/users?q=$search&page=$currrentPage&per_page=10');
//         final res = await http.get(url);
//         if (res.statusCode == 200) {
//          var data = jsonDecode(res.body)  ;
//           final info = data['items'];
//           return info;
//         }
//       } catch (error) {
//         print(error);
//       }
//     }else{
//       setState(() {
//         _show = true;
//       });
    
//       return null;
//     }
     
//   }

  // handlePage(int ? data)async{
  //   final currentPage = data ?? 1;
  //   final latestFromCall = await fetchUser(currentPage);
    
  //   if( latestFromCall != null){
  //     print(latestFromCall);
  //     setState(() {
  //       _info = latestFromCall;
  //     });
  //   }

  // }







  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Products",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.white),
                  child: ElevatedButton.icon(
                    onPressed:() {
                      Navigator.pushNamed(context, AddProductScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                    
                      backgroundColor: Colors.cyanAccent[400],
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Add New", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: appPadding,),
      
            Container(
          padding: const  EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [          
              SizedBox(
                width: double.infinity,
                child:SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    child: DataTable(  
                      dividerThickness: 2,
                      showBottomBorder: true,
                      dataRowHeight: 75,
                     sortAscending: _sortAsc,
                      sortColumnIndex: _sortIndex,     
                    columns:  [
                      DataColumn(label: Text('Image'),
                         numeric: true,
                      ),
                      DataColumn(label: Text('Name'),
                         onSort: setSort,
                        ),
                      DataColumn(label: Text('Price'),
                         onSort: setSort,
                          numeric: true,
                        ),
                      DataColumn(label: Text('Actions'),
                          numeric: true,
                        )
                      ],
                  
                    rows: getProductRow(),
                    columnSpacing: 100,
                    horizontalMargin: 20,     
                    showCheckboxColumn: false,
                            ),
                  ),
                ),      
              ),
               products.isNotEmpty ? NumberPagination(
              onPageChanged: (int pageNumber) {       
                setState(() {
                  selectedPage= pageNumber;
                });
                handlePageChanged(pageNumber);
              },
              pageTotal: totalPage,
              threshold: 2,
              fontSize: 10,
              pageInit: selectedPage,
              colorPrimary: Colors.greenAccent,
              colorSub: Colors.grey[800]!,
            ) : const SizedBox.shrink(),



            // const SizedBox(height: 10,),
            // // demo
            //   SizedBox(
            //     width: double.infinity,
            //     child:SingleChildScrollView(
            //           scrollDirection: Axis.vertical,
            //       child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //         child: DataTable(  
            //           dividerThickness: 2,
            //           showBottomBorder: true,
            //           dataRowHeight: 75,
            //          sortAscending: _sortAsc,
            //           sortColumnIndex: _sortIndex,     
            //         columns:  [
            //           DataColumn(label: Text('ID'),
            //              numeric: true,
            //               onSort: setSort,
            //           ),
            //           DataColumn(label: Text('Name'),
            //              onSort: setSort,
            //             ),
            //           DataColumn(label: Text('Price'),
            //              onSort: setSort,
            //               numeric: true,
            //             )
            //           ],
                  
            //         rows: getRow(),
            //         columnSpacing: 100,
            //         horizontalMargin: 20,     
            //         showCheckboxColumn: false,
            //                 ),
            //       ),
            //     ),      
            //   ),
            //     NumberPagination(
            //   onPageChanged: (int pageNumber) {
            //     //do somthing for selected page
            //     setState(() {
            //       selectedPageNumber = pageNumber;
            //     });
            //     // handlePage(pageNumber);
            //   },
            //   pageTotal: 100,
            //   threshold: 2,
            //   fontSize: 10,
            //   pageInit: selectedPageNumber, // picked number when init page
            //   colorPrimary: Colors.greenAccent,
            //   colorSub: Colors.grey[800]!,
            // ),
            ],
          ),
        ),
      
      
      
            // Container(
            //   alignment: Alignment.center,
            //   height: 100,
            //   color: Color.fromARGB(255, 149, 149, 143),
            //   child: Text('PAGE INFO $selectedPageNumber'), //do manage state
            // ),
            // NumberPagination(
            //   onPageChanged: (int pageNumber) {
            //     //do somthing for selected page
            //     setState(() {
            //       selectedPageNumber = pageNumber;
            //     });
            //     handlePage(pageNumber);
            //   },
            //   pageTotal: 100,
            //   pageInit: selectedPageNumber, // picked number when init page
            //   colorPrimary: Colors.red,
            //   colorSub: Colors.yellow,
            // ),
          ],
        ),
      ),
    );
  }

 List<DataRow> getProductRow() {
    return products.map((data) => 
     DataRow(cells: [
      DataCell(CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 30,
        backgroundImage:NetworkImage(data.images.first,) ),),
      DataCell(Text(data.name, textAlign: TextAlign.start)),
      DataCell(Text(data.price.toString(), textAlign: TextAlign.start)),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        IconButton(onPressed: () async{
          Navigator.pushNamed(context, AddProductScreen.routeName, arguments: data).then((value) =>     fetchAllProducts(1));
        }, icon: const Icon(Icons.edit_calendar))
      ],)),
    ])).toList();
    
  }

//  List<DataRow> getRow() {
//     return _info.map((data) => 
//      DataRow(cells: [
//       DataCell(Text(data['id'].toString(), textAlign: TextAlign.start,)),
//       DataCell(Text(data["login"], textAlign: TextAlign.start)),
//       DataCell(Text(data["node_id"].toString(), textAlign: TextAlign.start))
//     ])).toList();
    
//   }
}



















//  <ReactPaginate
//               previousLabel={"Previous"}
//               nextLabel={"Next"}
//               breakLabel={"..."}
//               pageCount={pageCount}
//               pageRangeDisplayed={5}
//               marginPagesDisplayed={2}
//               onPageChange={handlePage}
//               containerClassName={"pagination justify-content-center"}
//               pageClassName={"page-item"}
//               pageLinkClassName={"page-link"}
//               previousClassName={"page-item"}
//               nextClassName={"page-item"}
//               previousLinkClassName={"page-link"}
//               nextLinkClassName={"page-link"}
//               breakClassName={"page-item"}
//               breakLinkClassName={"page-link"}
//               activeClassName={"active"}
//             />



// class MyData extends DataTableSource {
//   // Generate some made-up data
//   final List<Map<String, dynamic>> _data = List.generate(
//       200,
//       (index) => {
//             "id": index,
//             "title": "Item $index",
//             "price": Random().nextInt(10000)
//           });

//   @override
//   bool get isRowCountApproximate => true;
//   @override
//   int get rowCount => _data.length;
//   @override
//   int get selectedRowCount => 0;
//   @override
//   DataRow getRow(int index) {
//     return DataRow(cells: [
//       DataCell(Text(_data[index]['id'].toString())),
//       DataCell(Text(_data[index]["title"])),
//       DataCell(Text(_data[index]["price"].toString())),
//     ]);
//   }
// }