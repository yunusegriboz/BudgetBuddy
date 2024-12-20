import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addexpense_screen.dart';
import 'addincome_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalBalance = 0.0;
  List<String> incomes = [];
  bool _isLoading = false;
  String _errorMessage = '';
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _screen();
  }

  Future<void> _screen() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    const url = API_BASE + API_EXPENDITURES; // API URL'nizi buraya ekleyin
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          final incomes = responseData['data'].map<String>((income) {
            return '${income['title']}|${income['description']}|${income['amount']}|${income['spending_date']}|${income['type']}';
          }).toList();

          totalIncome = 0;
          totalExpense = 0;

          responseData['data'].forEach((item) {
            final amount = double.tryParse(item['amount']) ?? 0.0;
            item['type'] == 1 ? totalIncome += amount : totalExpense += amount;
          });

          totalBalance = totalIncome - totalExpense;

          setState(() {
            this.incomes = incomes;
          });
        }
      }
    } catch (error) {
      setState(() {
        _errorMessage = '{$error}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(String title, String description, String amount,
      String spendingDate, Color backgroundColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          SizedBox(height: 4),
          Text(
            '\$${amount}',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            spendingDate,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BudgetBuddy'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _clearToken();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Color(0xFF236570), Color(0xFF7ED647)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Durum',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$${totalBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...incomes.map((income) {
                  final parts = income.split('|');
                  return _buildListItem(parts[0], parts[1], parts[2], parts[3],
                      parts[4] == "1" ? Colors.green : Colors.red);
                }).toList(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mevcut Durumunuz:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${totalBalance.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: totalBalance >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddIncome()),
            ).then((_) => _screen()),
            tooltip: 'Gelir Ekle',
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddExpense()),
            ).then((_) => _screen()),
            tooltip: 'Gider Ekle',
            child: Icon(Icons.remove, color: Colors.white),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
