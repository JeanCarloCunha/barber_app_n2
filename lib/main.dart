import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // pra sair do app

void main() {
  runApp(const MyApp());
}

// helper pra manter 2 casas decimais sempre
String formatMoney(num v) => 'R\$ ${v.toStringAsFixed(2)}';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barber APP',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/tela3': (context) => const Tela3(),
        '/sair': (context) => const SairPage(),

        // PRODUTOS
        '/produtos': (context) => const ProdutosMenuPage(),
        '/produtos/novo': (context) => const NovoProdutoPage(),
        '/produtos/lista': (context) => const ListaProdutosPage(),
        '/produtos/editar_codigo': (context) => EditarProdutoCodigoPage(),
        '/produtos/editar_dados': (context) => EditarProdutoDadosPage(),
        '/produtos/excluir': (context) => ExcluirProdutoPage(),

        // VENDAS (venda do dia)
        '/vendas': (context) => const VendaMenuPage(),
        '/vendas/nova': (context) => const VendaNovaPage(),
        '/vendas/lista': (context) => const VendaListaPage(),
        '/vendas/editar_numero': (context) => VendaEditarNumeroPage(),
        '/vendas/editar_dados': (context) => VendaEditarDadosPage(),
        '/vendas/excluir': (context) => VendaExcluirPage(),

        // RELATÓRIOS
        '/relatorios': (context) => const RelatoriosMenuPage(),
        '/relatorios/ultimo': (context) => const RelatorioUltimoPage(),
        '/relatorios/mensal': (context) => const RelatorioMensalPage(),
        '/relatorios/anual': (context) => const RelatorioAnualPage(),
        '/relatorios/editar_numero': (context) => RelatorioEditarNumeroPage(),
        '/relatorios/editar_dados': (context) => RelatorioEditarDadosPage(),
        '/relatorios/excluir': (context) => RelatorioExcluirPage(),
      },
    );
  }
}

//
// ===================================================
// =============== TELA 01: LOGIN ====================
// ===================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushNamed('/tela3');
    }
  }

  void _irParaCadastro() async {
    await Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Barber APP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bem-vindo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _userController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: const Icon(Icons.person),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Informe o username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Senha (mín. 4 caracteres)',
                        prefixIcon: const Icon(Icons.lock),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (v) {
                        if ((v ?? '').length < 4) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _login,
                        icon: const Icon(Icons.login),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _irParaCadastro,
                        icon: const Icon(Icons.app_registration),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text('Cadastrar', style: TextStyle(fontSize: 16)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white70),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =============== TELA 02: CADASTRO =================
// ===================================================
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const Color kRed = Color(0xFFE53935);

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushNamed('/sair');
    }
  }

  void _fecharComX() {
    Navigator.of(context).pushNamed('/sair');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: kRed,
                  foregroundColor: Colors.white,
                ),
                onPressed: _fecharComX,
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Cadastro - Barber APP',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _userController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'ex: jean.carlo',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Informe um username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'mín. 4 caracteres',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                    validator: (v) {
                      if ((v ?? '').length < 4) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _cadastrar,
                      icon: const Icon(Icons.check),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Cadastrar', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =============== TELA 03: MENU =====================
// ===================================================
class Tela3 extends StatelessWidget {
  const Tela3({super.key});

  static const Color kRed = Color(0xFFE53935);

  void _sairDoApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A5298), Color(0xFF1E3C72)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.store, size: 72, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    'Barber APP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _BigMenuButton(
                    label: 'Cadastrar Produto',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/produtos');
                    },
                  ),
                  const SizedBox(height: 14),
                  _BigMenuButton(
                    label: 'Venda do dia',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/vendas');
                    },
                  ),
                  const SizedBox(height: 14),
                  _BigMenuButton(
                    label: 'Relatórios',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/relatorios');
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _sairDoApp,
                      style: FilledButton.styleFrom(
                        backgroundColor: kRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sair', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BigMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _BigMenuButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

//
// ===================================================
// =============== TELA 04: SAIR =====================
// ===================================================
class SairPage extends StatelessWidget {
  const SairPage({super.key});

  void _sair() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    const Color kRed = Color(0xFFE53935);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.exit_to_app, size: 80, color: Colors.white),
                const SizedBox(height: 16),
                const Text(
                  'Vai sair do Barber APP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tela só para representar o fim do fluxo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _sair,
                  style: FilledButton.styleFrom(
                    backgroundColor: kRed,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Fechar APP'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// ======== TELA: MENU DE PRODUTOS (2 BOTÕES) ========
// ===================================================
class ProdutosMenuPage extends StatelessWidget {
  const ProdutosMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Cadastrar Produto'),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BigMenuButton(
                label: 'Criar Novo Produto',
                onPressed: () {
                  Navigator.of(context).pushNamed('/produtos/novo');
                },
              ),
              const SizedBox(height: 14),
              _BigMenuButton(
                label: 'Lista de produto',
                onPressed: () {
                  Navigator.of(context).pushNamed('/produtos/lista');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =============== TELA: NOVO PRODUTO ================
// ===================================================
class NovoProdutoPage extends StatefulWidget {
  const NovoProdutoPage({super.key});

  @override
  State<NovoProdutoPage> createState() => _NovoProdutoPageState();
}

class _NovoProdutoPageState extends State<NovoProdutoPage> {
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  static const Color kGreen = Color(0xFF2E7D32);

  @override
  void dispose() {
    _codigoController.dispose();
    _nomeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _salvarProduto() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Produto salvo com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // fecha popup
                Navigator.of(context).pushReplacementNamed('/produtos/lista');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Criar Novo Produto'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                children: [
                  TextField(
                    controller: _codigoController,
                    decoration: InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _valorController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _salvarProduto,
                      style: FilledButton.styleFrom(
                        backgroundColor: kGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Adicionar Novo Produto'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =============== TELA: LISTA DE PRODUTO ============
// ===================================================
class ListaProdutosPage extends StatefulWidget {
  const ListaProdutosPage({super.key});

  @override
  State<ListaProdutosPage> createState() => _ListaProdutosPageState();
}

class _ListaProdutosPageState extends State<ListaProdutosPage> {
  final List<Map<String, dynamic>> _produtos = [
    {'codigo': '001', 'nome': 'Produto 01', 'valor': 10.0},
    {'codigo': '002', 'nome': 'Produto 02', 'valor': 20.5},
    {'codigo': '003', 'nome': 'Produto 03', 'valor': 35.9},
  ];

  static const Color kBlue = Color(0xFF1565C0);
  static const Color kRed = Color(0xFFE53935);

  Future<void> _editarFluxo() async {
    final result = await Navigator.of(context).pushNamed(
      '/produtos/editar_codigo',
      arguments: _produtos,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      final Map<String, dynamic> produto =
      result['produto'] as Map<String, dynamic>;
      setState(() {
        _produtos[index] = produto;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto editado com sucesso.')),
      );
    }
  }

  Future<void> _excluirFluxo() async {
    final result = await Navigator.of(context).pushNamed(
      '/produtos/excluir',
      arguments: _produtos,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      setState(() {
        _produtos.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto excluído com sucesso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Lista de Produto'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFECEFF1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: const Text(
              'Nº / Produto / Valor',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final item = _produtos[index];
                return ListTile(
                  title: Text(item['nome']),
                  subtitle: Text(
                      'Código: ${item['codigo']} • Valor: ${formatMoney(item['valor'])}'),
                  leading: const Icon(Icons.inventory_2_outlined),
                );
              },
            ),
          ),
          SafeArea(
            minimum:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _editarFluxo,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _excluirFluxo,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// ===================================================
// =========== TELA 1: EDITAR PRODUTO → PERGUNTA CÓDIGO
// ===================================================
class EditarProdutoCodigoPage extends StatefulWidget {
  EditarProdutoCodigoPage({super.key});

  @override
  State<EditarProdutoCodigoPage> createState() =>
      _EditarProdutoCodigoPageState();
}

class _EditarProdutoCodigoPageState extends State<EditarProdutoCodigoPage> {
  final _codigoController = TextEditingController();
  List<Map<String, dynamic>> _produtos = [];

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _produtos = args;
    }
  }

  Future<void> _continuar() async {
    final codigo = _codigoController.text.trim();
    final index =
    _produtos.indexWhere((element) => element['codigo'].toString() == codigo);

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código não encontrado na lista.')),
      );
      return;
    }

    final produto = _produtos[index];

    final result = await Navigator.of(context).pushNamed(
      '/produtos/editar_dados',
      arguments: {
        'index': index,
        'produto': produto,
      },
    );

    if (!mounted) return;
    if (result is Map<String, dynamic>) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Produto'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual o código do item que você quer mudar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codigoController,
                  decoration: InputDecoration(
                    labelText: 'Código do item',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _continuar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =========== TELA 2: EDITAR PRODUTO → DADOS NOVOS ===
// ===================================================
class EditarProdutoDadosPage extends StatefulWidget {
  EditarProdutoDadosPage({super.key});

  @override
  State<EditarProdutoDadosPage> createState() =>
      _EditarProdutoDadosPageState();
}

class _EditarProdutoDadosPageState extends State<EditarProdutoDadosPage> {
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  int? _index;

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _index = args['index'] as int?;
      final produto = args['produto'] as Map<String, dynamic>;
      _codigoController.text = produto['codigo']?.toString() ?? '';
      _nomeController.text = produto['nome']?.toString() ?? '';
      _valorController.text = produto['valor']?.toString() ?? '';
    }
  }

  void _editar() {
    if (_index == null) {
      Navigator.of(context).pop();
      return;
    }

    final novo = {
      'codigo': _codigoController.text.trim(),
      'nome': _nomeController.text.trim(),
      'valor': double.tryParse(_valorController.text.trim()) ?? 0.0,
    };

    Navigator.of(context).pop({
      'index': _index,
      'produto': novo,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Produto'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Nome do Código do Produto que deseja editar',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codigoController,
                  decoration: InputDecoration(
                    labelText: 'Código novo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome de Produto Novo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Valor novo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _editar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// =========== TELA: EXCLUIR PRODUTO =================
// ===================================================
class ExcluirProdutoPage extends StatefulWidget {
  ExcluirProdutoPage({super.key});

  @override
  State<ExcluirProdutoPage> createState() => _ExcluirProdutoPageState();
}

class _ExcluirProdutoPageState extends State<ExcluirProdutoPage> {
  final _codigoController = TextEditingController();
  List<Map<String, dynamic>> _produtos = [];

  static const Color kRed = Color(0xFFE53935);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _produtos = args;
    }
  }

  void _excluir() {
    final codigo = _codigoController.text.trim();
    final index =
    _produtos.indexWhere((element) => element['codigo'].toString() == codigo);

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto não encontrado.')),
      );
      return;
    }

    Navigator.of(context).pop({'index': index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Excluir Produto'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual produto você deseja excluir?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codigoController,
                  decoration: InputDecoration(
                    labelText: 'Código do produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _excluir,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// ================= VENDAS (VENDA DO DIA) ===========
// ===================================================
class VendaMenuPage extends StatelessWidget {
  const VendaMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Venda do dia'),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BigMenuButton(
                label: 'Adicionar Nova Venda',
                onPressed: () {
                  Navigator.of(context).pushNamed('/vendas/nova');
                },
              ),
              const SizedBox(height: 14),
              _BigMenuButton(
                label: 'Vendas do dia',
                onPressed: () {
                  Navigator.of(context).pushNamed('/vendas/lista');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VendaNovaPage extends StatefulWidget {
  const VendaNovaPage({super.key});

  @override
  State<VendaNovaPage> createState() => _VendaNovaPageState();
}

class _VendaNovaPageState extends State<VendaNovaPage> {
  final _numeroController = TextEditingController();
  final _codigoProdutoController = TextEditingController();
  final _nomeProdutoController = TextEditingController();
  final _valorController = TextEditingController();

  static const Color kGreen = Color(0xFF2E7D32);

  Future<void> _salvar() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sucesso'),
        content: const Text('Venda registrada com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/vendas/lista');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Nova Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                children: [
                  TextField(
                    controller: _numeroController,
                    decoration: InputDecoration(
                      labelText: 'Nº Registro da Venda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _codigoProdutoController,
                    decoration: InputDecoration(
                      labelText: 'Código do Produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nomeProdutoController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _valorController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _salvar,
                      style: FilledButton.styleFrom(
                        backgroundColor: kGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Adicionar Nova Venda'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VendaListaPage extends StatefulWidget {
  const VendaListaPage({super.key});

  @override
  State<VendaListaPage> createState() => _VendaListaPageState();
}

class _VendaListaPageState extends State<VendaListaPage> {
  final List<Map<String, dynamic>> _vendas = [
    {
      'numero': '101',
      'codigo': '001',
      'nome': 'Produto 01',
      'valor': 10.0,
      'dia': '02',
      'mes': '11',
      'ano': '2025'
    },
    {
      'numero': '102',
      'codigo': '002',
      'nome': 'Produto 02',
      'valor': 22.5,
      'dia': '02',
      'mes': '11',
      'ano': '2025'
    },
    {
      'numero': '103',
      'codigo': '003',
      'nome': 'Produto 03',
      'valor': 35.9,
      'dia': '02',
      'mes': '11',
      'ano': '2025'
    },
  ];

  final _diaController = TextEditingController(text: '02');
  final _mesController = TextEditingController(text: '11');
  final _anoController = TextEditingController(text: '2025');

  static const Color kBlue = Color(0xFF1565C0);
  static const Color kRed = Color(0xFFE53935);
  static const Color kGreen = Color(0xFF2E7D32);

  @override
  void dispose() {
    _diaController.dispose();
    _mesController.dispose();
    _anoController.dispose();
    super.dispose();
  }

  Future<void> _editarFluxo() async {
    final result = await Navigator.of(context).pushNamed(
      '/vendas/editar_numero',
      arguments: _vendas,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      final Map<String, dynamic> venda =
      result['venda'] as Map<String, dynamic>;
      setState(() {
        _vendas[index] = venda;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Venda editada com sucesso.')),
      );
    }
  }

  Future<void> _excluirFluxo() async {
    final result = await Navigator.of(context).pushNamed(
      '/vendas/excluir',
      arguments: _vendas,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      setState(() {
        _vendas.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Venda excluída com sucesso.')),
      );
    }
  }

  void _fecharVendaDoDia() {
    Navigator.of(context).pushNamed(
      '/relatorios/ultimo',
      arguments: {
        'dia': _diaController.text.trim(),
        'mes': _mesController.text.trim(),
        'ano': _anoController.text.trim(),
        'registros': List<Map<String, dynamic>>.from(_vendas),
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Venda do dia fechada e enviada ao relatório.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Venda do dia'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _diaController,
                    decoration: const InputDecoration(
                      labelText: 'Dia',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _mesController,
                    decoration: const InputDecoration(
                      labelText: 'Mês',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _anoController,
                    decoration: const InputDecoration(
                      labelText: 'Ano',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _fecharVendaDoDia,
                  style: FilledButton.styleFrom(
                    backgroundColor: kGreen,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  ),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFECEFF1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: const Text(
              'Nº / Produto / Valor',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _vendas.length,
              itemBuilder: (context, index) {
                final item = _vendas[index];
                return ListTile(
                  title: Text('${item['nome']} (${formatMoney(item['valor'])})'),
                  subtitle: Text(
                      'Nº: ${item['numero']} • Cod: ${item['codigo']} • ${item['dia']}/${item['mes']}/${item['ano']}'),
                  leading: const Icon(Icons.receipt_long_outlined),
                );
              },
            ),
          ),
          SafeArea(
            minimum:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _editarFluxo,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _excluirFluxo,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// --------- VENDA → EDITAR (perguntar Nº) -----------
class VendaEditarNumeroPage extends StatefulWidget {
  VendaEditarNumeroPage({super.key});

  @override
  State<VendaEditarNumeroPage> createState() => _VendaEditarNumeroPageState();
}

class _VendaEditarNumeroPageState extends State<VendaEditarNumeroPage> {
  final _numeroController = TextEditingController();
  List<Map<String, dynamic>> _lista = [];

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _lista = args;
    }
  }

  Future<void> _continuar() async {
    final numero = _numeroController.text.trim();
    final index =
    _lista.indexWhere((element) => element['numero'].toString() == numero);

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Venda não encontrada.')),
      );
      return;
    }

    final venda = _lista[index];

    final result = await Navigator.of(context).pushNamed(
      '/vendas/editar_dados',
      arguments: {
        'index': index,
        'venda': venda,
      },
    );

    if (!mounted) return;
    if (result is Map<String, dynamic>) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual Nº da venda que você quer Editar ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº da venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _continuar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// --------- VENDA → EDITAR DADOS --------------------
class VendaEditarDadosPage extends StatefulWidget {
  VendaEditarDadosPage({super.key});

  @override
  State<VendaEditarDadosPage> createState() => _VendaEditarDadosPageState();
}

class _VendaEditarDadosPageState extends State<VendaEditarDadosPage> {
  final _numeroController = TextEditingController();
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  int? _index;

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _index = args['index'] as int?;
      final venda = args['venda'] as Map<String, dynamic>;
      _numeroController.text = venda['numero']?.toString() ?? '';
      _codigoController.text = venda['codigo']?.toString() ?? '';
      _nomeController.text = venda['nome']?.toString() ?? '';
      _valorController.text = venda['valor']?.toString() ?? '';
    }
  }

  void _editar() {
    if (_index == null) {
      Navigator.of(context).pop();
      return;
    }

    final venda = {
      'numero': _numeroController.text.trim(),
      'codigo': _codigoController.text.trim(),
      'nome': _nomeController.text.trim(),
      'valor': double.tryParse(_valorController.text.trim()) ?? 0.0,
      'dia': '02',
      'mes': '11',
      'ano': '2025',
    };

    Navigator.of(context).pop({
      'index': _index,
      'venda': venda,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  '[Nome do Código do Produto] que deseja editar',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº Registro da Venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _codigoController,
                  decoration: InputDecoration(
                    labelText: 'COD. Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _editar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// --------- VENDA → EXCLUIR -------------------------
class VendaExcluirPage extends StatefulWidget {
  VendaExcluirPage({super.key});

  @override
  State<VendaExcluirPage> createState() => _VendaExcluirPageState();
}

class _VendaExcluirPageState extends State<VendaExcluirPage> {
  final _numeroController = TextEditingController();
  List<Map<String, dynamic>> _lista = [];

  static const Color kRed = Color(0xFFE53935);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _lista = args;
    }
  }

  void _excluir() {
    final numero = _numeroController.text.trim();
    final index =
    _lista.indexWhere((element) => element['numero'].toString() == numero);
    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro não encontrado.')),
      );
      return;
    }

    Navigator.of(context).pop({'index': index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Excluir Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual Nº Registro da venda?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº Registro da venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _excluir,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir Venda'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ===================================================
// ===================== RELATÓRIOS ==================
// ===================================================
class RelatoriosMenuPage extends StatelessWidget {
  const RelatoriosMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Relatórios'),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BigMenuButton(
                label: 'Último Fechamento',
                onPressed: () {
                  Navigator.of(context).pushNamed('/relatorios/ultimo');
                },
              ),
              const SizedBox(height: 14),
              _BigMenuButton(
                label: 'Relatório Mensal',
                onPressed: () {
                  Navigator.of(context).pushNamed('/relatorios/mensal');
                },
              ),
              const SizedBox(height: 14),
              _BigMenuButton(
                label: 'Relatório Anual',
                onPressed: () {
                  Navigator.of(context).pushNamed('/relatorios/anual');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// base de lista de relatório
class _RelatorioListaBase extends StatelessWidget {
  final String titulo;
  final List<Map<String, dynamic>> lista;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;
  const _RelatorioListaBase({
    required this.titulo,
    required this.lista,
    required this.onEditar,
    required this.onExcluir,
  });

  static const Color kBlue = Color(0xFF1565C0);
  static const Color kRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            Text(titulo),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFECEFF1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            // AQUI trocamos de "Nº" pra "Nº venda"
            child: const Text(
              'Nº venda / Produto / Valor',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final item = lista[index];
                return ListTile(
                  title: Text(
                      'Nº ${item['numero']} • ${item['nome']} (${formatMoney(item['valor'])})'),
                  subtitle: Text(
                      'Dia ${item['dia']}/${item['mes']}/${item['ano'] ?? ''} • Cod: ${item['codigo']}'),
                  leading: const Icon(Icons.description_outlined),
                );
              },
            ),
          ),
          SafeArea(
            minimum:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onEditar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: onExcluir,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// -------- Último Fechamento ------------------------
class RelatorioUltimoPage extends StatefulWidget {
  const RelatorioUltimoPage({super.key});

  @override
  State<RelatorioUltimoPage> createState() => _RelatorioUltimoPageState();
}

class _RelatorioUltimoPageState extends State<RelatorioUltimoPage> {
  List<Map<String, dynamic>> _registros = [
    {
      'numero': '201',
      'codigo': '010',
      'nome': 'Venda de Produto A',
      'valor': 55.0,
      'dia': '02',
      'mes': '11',
      'ano': '2025'
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['registros'] != null) {
      final List<Map<String, dynamic>> listaArg =
      (args['registros'] as List).map<Map<String, dynamic>>((e) {
        return Map<String, dynamic>.from(e as Map);
      }).toList();
      _registros = listaArg;
    }
  }

  Future<void> _editar() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/editar_numero',
      arguments: _registros,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      final Map<String, dynamic> venda =
      result['venda'] as Map<String, dynamic>;
      setState(() {
        _registros[index] = venda;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro editado com sucesso.')),
      );
    }
  }

  Future<void> _excluir() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/excluir',
      arguments: _registros,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      setState(() {
        _registros.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro excluído com sucesso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RelatorioListaBase(
      titulo: 'Último Fechamento',
      lista: _registros,
      onEditar: _editar,
      onExcluir: _excluir,
    );
  }
}

//
// -------- Relatório Mensal -------------------------
class RelatorioMensalPage extends StatefulWidget {
  const RelatorioMensalPage({super.key});

  @override
  State<RelatorioMensalPage> createState() => _RelatorioMensalPageState();
}

class _RelatorioMensalPageState extends State<RelatorioMensalPage> {
  String? _mesSelecionado;
  List<Map<String, dynamic>> _mensal = [
    {
      'numero': '301',
      'codigo': '020',
      'nome': 'Venda 01',
      'valor': 10.0,
      'dia': '01',
      'mes': '11',
      'ano': '2025'
    },
    {
      'numero': '302',
      'codigo': '021',
      'nome': 'Venda 02',
      'valor': 25.0,
      'dia': '02',
      'mes': '11',
      'ano': '2025'
    },
    {
      'numero': '303',
      'codigo': '022',
      'nome': 'Venda 03',
      'valor': 30.0,
      'dia': '03',
      'mes': '11',
      'ano': '2025'
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['mes'] != null) {
      _mesSelecionado = args['mes'] as String;
      _mensal =
          _mensal.where((e) => e['mes']?.toString() == _mesSelecionado).toList();
    }
  }

  Future<void> _editar() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/editar_numero',
      arguments: _mensal,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      final Map<String, dynamic> venda =
      result['venda'] as Map<String, dynamic>;
      setState(() {
        _mensal[index] = venda;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro mensal editado.')),
      );
    }
  }

  Future<void> _excluir() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/excluir',
      arguments: _mensal,
    );

    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      setState(() {
        _mensal.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro mensal excluído.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titulo = _mesSelecionado == null
        ? 'Relatório Mensal'
        : 'Relatório Mensal - Mês ${_mesSelecionado!}';

    return _RelatorioListaBase(
      titulo: titulo,
      lista: _mensal,
      onEditar: _editar,
      onExcluir: _excluir,
    );
  }
}

//
// -------- Relatório Anual --------------------------
class RelatorioAnualPage extends StatefulWidget {
  const RelatorioAnualPage({super.key});

  @override
  State<RelatorioAnualPage> createState() => _RelatorioAnualPageState();
}

class _RelatorioAnualPageState extends State<RelatorioAnualPage> {
  final List<Map<String, dynamic>> _anual = [
    {
      'numero': '401',
      'codigo': '030',
      'nome': 'Registros de Janeiro',
      'valor': 100.0,
      'dia': '10',
      'mes': '01',
      'ano': '2025'
    },
    {
      'numero': '402',
      'codigo': '031',
      'nome': 'Registros de Abril',
      'valor': 150.0,
      'dia': '14',
      'mes': '04',
      'ano': '2025'
    },
    {
      'numero': '403',
      'codigo': '032',
      'nome': 'Registros de Agosto',
      'valor': 80.0,
      'dia': '09',
      'mes': '08',
      'ano': '2025'
    },
  ];

  void _abrirMes(Map<String, dynamic> item) {
    final mes = item['mes']?.toString() ?? '';
    Navigator.of(context).pushNamed('/relatorios/mensal', arguments: {
      'mes': mes,
    });
  }

  Future<void> _editar() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/editar_numero',
      arguments: _anual,
    );
    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      final Map<String, dynamic> venda =
      result['venda'] as Map<String, dynamic>;
      setState(() {
        _anual[index] = venda;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro anual editado.')),
      );
    }
  }

  Future<void> _excluir() async {
    final result = await Navigator.of(context).pushNamed(
      '/relatorios/excluir',
      arguments: _anual,
    );
    if (result is Map<String, dynamic>) {
      final int index = result['index'] as int;
      setState(() {
        _anual.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro anual excluído.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Relatório Anual'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFECEFF1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: const Text(
              'Meses com registro',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _anual.length,
              itemBuilder: (context, index) {
                final item = _anual[index];
                return ListTile(
                  onTap: () => _abrirMes(item),
                  title: Text('${item['nome']}'),
                  subtitle: Text(
                      'Mês: ${item['mes']} • Total: ${formatMoney(item['valor'])}'),
                  leading: const Icon(Icons.calendar_month),
                  trailing:
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                );
              },
            ),
          ),
          SafeArea(
            minimum:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _editar,
                    child: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _excluir,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                    ),
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//
// --------- RELATÓRIO → EDITAR (pergunta nº) --------
class RelatorioEditarNumeroPage extends StatefulWidget {
  RelatorioEditarNumeroPage({super.key});

  @override
  State<RelatorioEditarNumeroPage> createState() =>
      _RelatorioEditarNumeroPageState();
}

class _RelatorioEditarNumeroPageState
    extends State<RelatorioEditarNumeroPage> {
  final _numeroController = TextEditingController();
  List<Map<String, dynamic>> _lista = [];

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _lista = args;
    }
  }

  Future<void> _continuar() async {
    final numero = _numeroController.text.trim();
    final index =
    _lista.indexWhere((element) => element['numero'].toString() == numero);

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro não encontrado.')),
      );
      return;
    }

    final venda = _lista[index];

    final result = await Navigator.of(context).pushNamed(
      '/relatorios/editar_dados',
      arguments: {
        'index': index,
        'venda': venda,
      },
    );

    if (!mounted) return;
    if (result is Map<String, dynamic>) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual Nº da venda que você quer Editar ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº da venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _continuar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// --------- RELATÓRIO → EDITAR DADOS ----------------
class RelatorioEditarDadosPage extends StatefulWidget {
  RelatorioEditarDadosPage({super.key});

  @override
  State<RelatorioEditarDadosPage> createState() =>
      _RelatorioEditarDadosPageState();
}

class _RelatorioEditarDadosPageState
    extends State<RelatorioEditarDadosPage> {
  final _numeroController = TextEditingController();
  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  int? _index;

  static const Color kBlue = Color(0xFF1565C0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _index = args['index'] as int?;
      final venda = args['venda'] as Map<String, dynamic>;
      _numeroController.text = venda['numero']?.toString() ?? '';
      _codigoController.text = venda['codigo']?.toString() ?? '';
      _nomeController.text = venda['nome']?.toString() ?? '';
      _valorController.text = venda['valor']?.toString() ?? '';
    }
  }

  void _editar() {
    if (_index == null) {
      Navigator.of(context).pop();
      return;
    }

    final venda = {
      'numero': _numeroController.text.trim(),
      'codigo': _codigoController.text.trim(),
      'nome': _nomeController.text.trim(),
      'valor': double.tryParse(_valorController.text.trim()) ?? 0.0,
      'dia': '02',
      'mes': '11',
      'ano': '2025',
    };

    Navigator.of(context).pop({
      'index': _index,
      'venda': venda,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Editar Venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  '[Nome do Código do Produto] que deseja editar',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº Registro da Venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _codigoController,
                  decoration: InputDecoration(
                    labelText: 'COD. Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _editar,
                    style: FilledButton.styleFrom(
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Editar Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// --------- RELATÓRIO → EXCLUIR ---------------------
class RelatorioExcluirPage extends StatefulWidget {
  RelatorioExcluirPage({super.key});

  @override
  State<RelatorioExcluirPage> createState() => _RelatorioExcluirPageState();
}

class _RelatorioExcluirPageState extends State<RelatorioExcluirPage> {
  final _numeroController = TextEditingController();
  List<Map<String, dynamic>> _lista = [];

  static const Color kRed = Color(0xFFE53935);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>?;
    if (args != null) {
      _lista = args;
    }
  }

  void _excluir() {
    final numero = _numeroController.text.trim();
    final index =
    _lista.indexWhere((element) => element['numero'].toString() == numero);
    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro não encontrado.')),
      );
      return;
    }

    Navigator.of(context).pop({'index': index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            ),
            const SizedBox(width: 8),
            const Text('Excluir Registro de venda'),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F6FA),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const Text(
                  'Qual Nº Registro da venda?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Nº Registro da venda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _excluir,
                    style: FilledButton.styleFrom(
                      backgroundColor: kRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Excluir Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
