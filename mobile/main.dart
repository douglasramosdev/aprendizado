import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ItaHelpCupertinoApp());
}

class ItaHelpCupertinoApp extends StatelessWidget {
  const ItaHelpCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Ita Help',
      home: ItaHelpHome(),
    );
  }
}

class ItaHelpHome extends StatefulWidget {
  const ItaHelpHome({super.key});

  @override
  State<ItaHelpHome> createState() => _ItaHelpHomeState();
}

class _ItaHelpHomeState extends State<ItaHelpHome>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  // Produtos
  final List<ProductModel> products = [
    ProductModel(
      name: 'iPhone 16 Pro Max',
      description: 'Apple A18 Pro, Titanium body, iOS 19',
      price: 1899.99,
      image:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-1-202209?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1660753619946',
      colors: ['Space Black', 'Silver', 'Gold', 'Deep Purple'],
      availableStorage: [256, 512, 1024],
    ),
    ProductModel(
      name: 'Samsung Galaxy S25 Ultra',
      description: '200MP camera, Snapdragon 8 Gen 4, Android 15',
      price: 1799.99,
      image:
          'https://images.samsung.com/is/image/samsung/p6pim/br/galaxy-s23/gallery/br-galaxy-s23-s911-sm-s911bzidzto-530566710?\$720_576_PNG\$',
      colors: ['Phantom Black', 'Green', 'Cream', 'Lavender'],
      availableStorage: [256, 512, 1024],
    ),
    ProductModel(
      name: 'Google Pixel 10 Pro',
      description: 'Tensor G4 chip, Pure Android 15, 7 anos de garantia',
      price: 1299.99,
      image: 'https://store.google.com/us/product/images/hero_pixel_7.webp',
      colors: ['Obsidian', 'Snow', 'Hazel'],
      availableStorage: [128, 256, 512],
    ),
    ProductModel(
      name: 'Xiaomi 15 Ultra',
      description: 'Leica Camera, Snapdragon 8 Gen 4, HyperOS',
      price: 999.99,
      image:
          'https://image01.oneplus.net/ebp/202302/20/1-m00-16-0a-rb8bwl-ircyaln2caaaqdmkaant638.png',
      colors: ['Black', 'White', 'Green'],
      availableStorage: [256, 512],
    ),
    ProductModel(
      name: 'Xiaomi Redmi Note 12',
      description: 'Leica Camera, Snapdragon 8 Gen 4, HyperOS',
      price: 999.99,
      image:
          'https://cdn.dxomark.com/wp-content/uploads/medias/post-109532/xiaomi-redmi-note-12-pro-pic2.jpg',
      colors: ['Onyx Gray', 'Ice Blue', 'Mint Green'],
      availableStorage: [128, 256],
    ),
    ProductModel(
      name: 'OnePlus 13 Pro',
      description: 'Snapdragon 9 Gen 1, OxygenOS 16',
      price: 1199.99,
      image:
          'https://www.gizmochina.com/wp-content/uploads/2023/12/oneplus-12-render-leak-featured.jpg',
      colors: ['Flowy Emerald', 'Silky Black'],
      availableStorage: [256, 512],
    ),
    ProductModel(
      name: 'Oppo Find X8 Pro',
      description: 'MariSilicon X3, ColorOS 16',
      price: 1399.99,
      image:
          'https://static.techoutlook.in/media/img/gallery/20231109/con_hd_1699523569_789877200_770x520.jpg',
      colors: ['Ceramic White', 'Gloss Black'],
      availableStorage: [512, 1024],
    ),
    ProductModel(
      name: 'Vivo X200 Pro',
      description: 'Dimensity 9400, OriginOS 16',
      price: 1099.99,
      image:
          'https://www.91mobiles.com/hi/wp-content/uploads/2023/11/vivo-x100-pro-render-2.jpg',
      colors: ['Asteroid Black', 'Meteorite Blue'],
      availableStorage: [256, 512],
    ),
    ProductModel(
      name: 'Realme GT4 Pro',
      description: 'Snapdragon 8 Gen 4, Realme UI 6.0',
      price: 899.99,
      image:
          'https://www.smartprix.com/bytes/wp-content/uploads/2023/11/realme-gt-5-pro-featured.jpg',
      colors: ['Racing Yellow', 'Starry Night'],
      availableStorage: [128, 256],
    ),
    ProductModel(
      name: 'Honor Magic7 Pro',
      description: 'Snapdragon 8 Gen 4, Magic UI 8.0',
      price: 1249.99,
      image:
          'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/20231226_Honor_Magic6_Pro_Leaks.png',
      colors: ['Black', 'Green', 'Purple'],
      availableStorage: [256, 512],
    ),
  ];

  List<CartItem> cart = [];

  User? loggedUser;

  // Controladores de login/cadastro
  final loginUserCtrl = TextEditingController();
  final loginPassCtrl = TextEditingController();

  final regUserCtrl = TextEditingController();
  final regPassCtrl = TextEditingController();
  final regEmailCtrl = TextEditingController();
  final regPhoneCtrl = TextEditingController();
  final regAddressCtrl = TextEditingController();

  Map<String, User> users = {};

  // Alternância entre login e cadastro
  bool showLogin = true;

  // CEP Controller
  final cepController = TextEditingController();
  double shippingPrice = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    cepController.dispose();
    loginUserCtrl.dispose();
    loginPassCtrl.dispose();
    regUserCtrl.dispose();
    regPassCtrl.dispose();
    regEmailCtrl.dispose();
    regPhoneCtrl.dispose();
    regAddressCtrl.dispose();
    super.dispose();
  }

  void addToCart(ProductModel product) {
    setState(() {
      final idx = cart.indexWhere((item) => item.product.name == product.name);
      if (idx >= 0) {
        cart[idx].quantity++;
      } else {
        cart.add(CartItem(product: product, quantity: 1));
      }
    });
  }

  void removeFromCart(ProductModel product) {
    setState(() {
      cart.removeWhere((item) => item.product.name == product.name);
    });
  }

  void changeQuantity(CartItem item, int delta) {
    setState(() {
      item.quantity += delta;
      if (item.quantity <= 0) cart.remove(item);
    });
  }

  double get cartTotal =>
      cart.fold(0, (total, item) => total + item.product.price * item.quantity);

  void login() {
    final user = loginUserCtrl.text.trim();
    final pass = loginPassCtrl.text.trim();
    if (users.containsKey(user) && users[user]!.password == pass) {
      setState(() {
        loggedUser = users[user];
        _tabController.animateTo(0);
        _currentIndex = 0; // Home
      });
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro'),
          content: const Text('Usuário ou senha inválidos'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildForgotPasswordButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Text(
        'Esqueci minha senha',
        style: TextStyle(
          color: CupertinoColors.activeBlue,
          fontSize: 14,
        ),
      ),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Recuperação de senha'),
            content: const Text(
                'Por favor, entre em contato com o suporte: suporte@itahelp.com'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void register() {
    final user = regUserCtrl.text.trim();
    final pass = regPassCtrl.text.trim();
    if (users.containsKey(user)) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro'),
          content: const Text('Usuário já existe'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }
    if (pass.length < 6) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro'),
          content: const Text('Senha deve ter pelo menos 6 caracteres'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }
    final newUser = User(
      username: user,
      password: pass,
      email: regEmailCtrl.text.trim(),
      phone: regPhoneCtrl.text.trim(),
      address: regAddressCtrl.text.trim(),
    );
    setState(() {
      users[user] = newUser;
      loggedUser = newUser;
      _tabController.animateTo(0);
      _currentIndex = 0;
    });
  }

  void logout() {
    setState(() {
      loggedUser = null;
      cart.clear();
      _tabController.animateTo(1);
      _currentIndex = 1;
      loginUserCtrl.clear();
      loginPassCtrl.clear();
      regUserCtrl.clear();
      regPassCtrl.clear();
      regEmailCtrl.clear();
      regPhoneCtrl.clear();
      regAddressCtrl.clear();
      showLogin = true;
    });
  }

  Future<void> calculateShipping() async {
    final cep = cepController.text.trim();
    if (cep.length != 8) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro'),
          content: const Text('CEP inválido. Digite um CEP com 8 dígitos.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    final url = 'https://viacep.com.br/ws/$cep/json/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (decodedJson.containsKey('erro')) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Erro'),
              content: const Text('CEP não encontrado.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
          return;
        }

        // Simulação do cálculo do frete (substitua pela lógica real)
        setState(() {
          shippingPrice = cartTotal > 1000 ? 0 : 20.0;
        });
      } else {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Erro'),
            content: const Text('Falha ao buscar o CEP.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro'),
          content: Text('Erro ao calcular o frete: $e'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void checkout() {
    if (loggedUser == null) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Atenção'),
          content:
              const Text('Você precisa estar logado para concluir a compra'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _tabController.animateTo(1);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        ),
      );
      return;
    }
    if (cart.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Carrinho vazio'),
          content: const Text(
              'Adicione produtos ao carrinho antes de concluir a compra'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    // Verifica se o CEP foi calculado
    if (shippingPrice == 0.0) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Atenção'),
          content: const Text('Calcule o frete antes de concluir a compra.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CheckoutPage(
          cartTotal: cartTotal,
          shippingPrice: shippingPrice,
          onBack: () {
            Navigator.pop(context);
          },
          onFinish: () {
            setState(() {
              cart.clear();
              shippingPrice = 0.0; // Reset shipping price
              _tabController.animateTo(0);
              _currentIndex = 0;
            });
            Navigator.pop(context);
          },
          loggedUser: loggedUser!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: CupertinoTabController(),
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: 'Login'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: 'Carrinho'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _tabController.animateTo(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return buildHomePage();
          case 1:
            return buildLoginRegisterPage();
          case 2:
            return buildCartPage();
          default:
            return Container();
        }
      },
    );
  }

  Widget buildHomePage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Ita Help - Home'),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, i) {
                final p = products[i];
                return ProductCard(product: p, addToCart: addToCart);
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildLoginRegisterPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Login / Cadastro'),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSlidingSegmentedControl<bool>(
                    groupValue: showLogin,
                    children: const {
                      true: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Login'),
                      ),
                      false: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Cadastro'),
                      ),
                    },
                    onValueChanged: (bool? value) {
                      setState(() {
                        showLogin = value ?? true;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (showLogin)
                    Column(
                      children: [
                        CupertinoTextField(
                          controller: loginUserCtrl,
                          placeholder: 'Usuário',
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: loginPassCtrl,
                          placeholder: 'Senha',
                          obscureText: true,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildForgotPasswordButton(),
                        const SizedBox(height: 10),
                        CupertinoButton.filled(
                          child: const Text('Login'),
                          onPressed: login,
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        CupertinoTextField(
                          controller: regUserCtrl,
                          placeholder: 'Usuário',
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: regPassCtrl,
                          placeholder: 'Senha (mínimo 6 caracteres)',
                          obscureText: true,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: regEmailCtrl,
                          placeholder: 'Email',
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: regPhoneCtrl,
                          placeholder: 'Telefone',
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoTextField(
                          controller: regAddressCtrl,
                          placeholder: 'Endereço',
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CupertinoButton.filled(
                          child: const Text('Cadastrar'),
                          onPressed: register,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCartPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Carrinho'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text('Carrinho vazio'),
                    )
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, i) {
                        final item = cart[i];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.systemGrey5,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.product.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const Icon(CupertinoIcons.photo);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$${item.product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: CupertinoColors.systemGreen,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: const Icon(
                                              CupertinoIcons.minus_circled),
                                          onPressed: () =>
                                              changeQuantity(item, -1),
                                        ),
                                        Text('${item.quantity}'),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: const Icon(
                                              CupertinoIcons.add_circled),
                                          onPressed: () =>
                                              changeQuantity(item, 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.trash),
                                onPressed: () => removeFromCart(item.product),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CupertinoTextField(
                    controller: cepController,
                    placeholder: 'Digite seu CEP',
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoButton.filled(
                    child: const Text('Calcular Frete'),
                    onPressed: calculateShipping,
                  ),
                  const SizedBox(height: 10),
                  Text('Frete: \$${shippingPrice.toStringAsFixed(2)}'),
                ],
              ),
            ),
            CupertinoButton.filled(
              child: const Text('Checkout'),
              onPressed: checkout,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.addToCart,
  });

  final ProductModel product;
  final void Function(ProductModel) addToCart;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String? selectedColor;
  int? selectedStorage;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product.colors.first;
    selectedStorage = widget.product.availableStorage.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CupertinoColors.systemGrey6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(CupertinoIcons.photo);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text('\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: CupertinoColors.systemGreen)),
                const SizedBox(height: 6),
                Text(
                  widget.product.description,
                  style: const TextStyle(
                      fontSize: 10, color: CupertinoColors.systemGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Cor: $selectedColor',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => CupertinoActionSheet(
                            title: const Text('Selecione a cor'),
                            actions: widget.product.colors
                                .map<Widget>(
                                  (color) => CupertinoActionSheetAction(
                                    onPressed: () {
                                      setState(() {
                                        selectedColor = color;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(color),
                                  ),
                                )
                                .toList(),
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Cancelar'),
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'GB: $selectedStorage',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => CupertinoActionSheet(
                            title: const Text('Selecione o armazenamento'),
                            actions: widget.product.availableStorage
                                .map<Widget>(
                                  (storage) => CupertinoActionSheetAction(
                                    onPressed: () {
                                      setState(() {
                                        selectedStorage = storage;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text('$storage GB'),
                                  ),
                                )
                                .toList(),
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Cancelar'),
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                CupertinoButton.filled(
                  onPressed: () => widget.addToCart(widget.product),
                  child: const Text('Adicionar ao carrinho'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductModel {
  final String name;
  final String description;
  final double price;
  final String image;
  final List<String> colors;
  final List<int> availableStorage;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.colors,
    required this.availableStorage,
  });
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class User {
  final String username;
  final String password;
  final String email;
  final String phone;
  final String address;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.cartTotal,
    required this.shippingPrice,
    required this.onBack,
    required this.onFinish,
    required this.loggedUser,
  }) : super(key: key);

  final double cartTotal;
  final double shippingPrice;
  final VoidCallback onBack;
  final VoidCallback onFinish;
  final User loggedUser;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = 'Cartão de Crédito'; // Default payment method

  @override
  Widget build(BuildContext context) {
    final total = widget.cartTotal + widget.shippingPrice;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Finalizar Compra'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: widget.onBack,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, ${widget.loggedUser.username}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('Subtotal: R\$ ${widget.cartTotal.toStringAsFixed(2)}'),
              Text('Frete: R\$ ${widget.shippingPrice.toStringAsFixed(2)}'),
              Text(
                'Total: R\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Método de Pagamento:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (index) {
                  setState(() {
                    paymentMethod = ['Cartão de Crédito', 'Pix', 'Boleto Bancário', 'Paypal'][index];
                  });
                },
                children: const [
                  Text('Cartão de Crédito'),
                  Text('Pix'),
                  Text('Boleto Bancário'),
                  Text('Paypal'),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Voltar'),
                    onPressed: widget.onBack,
                  ),
                  CupertinoButton.filled(
                    child: const Text('Finalizar Compra'),
                    onPressed: () {
                      // Add logic for payment processing based on paymentMethod
                      widget.onFinish();
                    },
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