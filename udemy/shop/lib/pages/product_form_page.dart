import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    var isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save(); //https://dummyimage.com/300/09f/fff.png

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  // TOD tentar implementar as validações futuramente com Design Pattern Chain of Responsability
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (value) {
                  final name = value ?? '';

                  if (name.trim().isEmpty) return 'Nome é obrigatório.';
                  if (name.trim().length < 3) return 'Nome precisa no mínimo de 3 letras.';

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocus),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
                validator: (value) {
                  final priceString = value ?? '-1';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) return 'Informe um preço válido.';

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocus),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) => _formData['description'] = description ?? '',
                validator: (value) {
                  final description = value ?? '';

                  if (description.trim().isEmpty) return 'Descrição é obrigatória.';
                  if (description.trim().length < 3) return 'Descrição mínima de 10 letras.';

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Url da Imagem'),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      validator: (value) {
                        final imageUrl = value ?? '';

                        if (!isValidImageUrl(imageUrl)) return 'Informe uma Url válida!';

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
