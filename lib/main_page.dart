import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test_propnext/data/datasources/product_remote_datasources.dart';
import 'package:technical_test_propnext/data/repositories/product_repository_impl.dart';
import 'package:technical_test_propnext/presentations/product/pages/inventory_page.dart';
import 'package:technical_test_propnext/presentations/product/provider/product_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
          dispose: (_, client) => client.close(),
        ),
        ProxyProvider<http.Client, ProductRemoteDataSource>(
          update: (_, client, __) => ProductRemoteDataSourceImpl(client: client),
        ),
        ProxyProvider<ProductRemoteDataSource, ProductRepositoryImpl>(
          update: (_, dataSource, __) => ProductRepositoryImpl(remoteDataSource: dataSource),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(
            repository: Provider.of<ProductRepositoryImpl>(context, listen: false),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        title: 'Inventory App',
        home: InventoryPage(),
      ),
    );
  }
}
