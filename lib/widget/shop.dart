import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Item {
  String name;
  double price;
  String image;

  Item({required this.name, required this.price, required this.image});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Item List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<Item> items = [
    Item(name: 'DIESE МАИЦА', price: 3423, image: 'https://www.fashiongroup.com.mk/files/watermark/files/images/slike-proizvoda/media/504/50494591-100/images/thumbs_w/50494591-100_w_800_1120px.jpg'),
    Item(name: 'CALVIN CLEIN МАИЦА', price: 4059, image: 'https://www.fashiongroup.com.mk/files/watermark/files/images/slike-proizvoda/media/504/50490775-420/images/thumbs_w/50490775-420_w_800_1120px.jpg'),
    Item(name: 'HUGO', price: 3029, image: 'https://www.fashiongroup.com.mk/files/watermark/files/images/slike-proizvoda/media/DM0/DM0DM16848-XNL/images/thumbs_w/DM0DM16848-XNL_w_800_1120px.jpg'),
    Item(name: 'MASSIMO', price: 2999, image: 'https://www.fashiongroup.com.mk/files/watermark/files/images/slike-proizvoda/media/J30/J30J324028-BEH/images/thumbs_w/J30J324028-BEH_w_800_1120px.jpg'),
    Item(name: 'TIMBERLAND', price: 1000, image: 'https://www.fashiongroup.com.mk/files/watermark/files/images/slike-proizvoda/media/A12/A125290CATM-9XX/images/thumbs_w/A125290CATM-9XX_w_800_1120px.jpg'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('206021'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${items[index].price.toString()}'),
                  SizedBox(height: 8.0),
                  Image.network(
                    items[index].image, // Replace 'imageUrl' with the actual property name in your Item class
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItemScreen(
                            item: items[index],
                            onItemUpdated: (updatedItem) {
                              setState(() {
                                items[index] = updatedItem;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                  // Delete button
                  TextButton(
                    onPressed: () {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(
                onItemAdded: (newItem) {
                  setState(() {
                    items.add(newItem);
                  });
                },
              ),
            ),
          );
        },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5.0), // Optional: You can adjust the border radius
            ),
            padding: EdgeInsets.all(10.0), // Optional: You can adjust the padding
            child: Text(
              'Add Item',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
      ),
    );
  }
}

class EditItemScreen extends StatefulWidget {
  final Item item;
  final Function(Item) onItemUpdated;

  EditItemScreen({required this.item, required this.onItemUpdated});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    priceController = TextEditingController(text: widget.item.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Item Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                double price = double.parse(priceController.text.trim());
                Item updatedItem = Item(name: name, price: price, image: widget.item.image);
                widget.onItemUpdated(updatedItem);
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddItemScreen extends StatefulWidget {
  final Function(Item) onItemAdded;

  AddItemScreen({required this.onItemAdded});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
    imageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Item Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Item Image URL'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                double price = double.parse(priceController.text.trim());
                String image = imageController.text.trim();
                Item newItem = Item(name: name, price: price, image: image);
                widget.onItemAdded(newItem);
                Navigator.pop(context);
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
