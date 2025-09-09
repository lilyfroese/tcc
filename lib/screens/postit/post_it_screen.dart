import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostItScreen extends StatefulWidget {
  const PostItScreen({super.key});

  @override
  State<PostItScreen> createState() => _PostItScreenState();
}

class _PostItScreenState extends State<PostItScreen> {
  final List<_PostIt> _postIts = [];
  final TextEditingController _controller = TextEditingController();
  Color _selectedColor = Colors.green;

  int? _editingIndex; // controla qual post-it está em edição
  int? _selectedIndex; // controla qual foi clicado/segurado

  final List<Color> _colors = [
    const Color(0xFF80CBC4),
    const Color(0xFFF48FB1),
    const Color(0xFFDCEDC8),
    const Color(0xFFFFCC80),
    const Color(0xFF80DEEA),
    const Color(0xFFCE93D8),
    const Color(0xFFDCE775),
    const Color(0xFFFFF59D),
    const Color(0xFFFFAB91),
  ];

  @override
  void initState() {
    super.initState();
    _loadPostIts();
  }

  Future<void> _loadPostIts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('postIts') ?? [];
    setState(() {
      _postIts.clear();
      _postIts.addAll(
        data.map((e) => _PostIt.fromJson(jsonDecode(e))),
      );
    });
  }

  Future<void> _savePostIts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _postIts.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('postIts', data);
  }

  void _openPostItModal({bool isEditing = false, int? index}) {
    if (isEditing && index != null) {
      _controller.text = _postIts[index].text;
      _selectedColor = _postIts[index].color;
      _editingIndex = index;
    } else {
      _controller.clear();
      _selectedColor = _colors[0];
      _editingIndex = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? "Editar Post-it" : "Novo Post-it",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[200]),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              decoration: const InputDecoration(
                hintText: "Escreva sua mensagem...",
                hintStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: _colors
                  .map((color) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: _selectedColor == color
                                ? Border.all(width: 3, color: Colors.white70)
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text("Cancelar", style: TextStyle(color: Colors.blue[200])),
                  onPressed: () {
                    _controller.clear();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isEditing ? "Salvar" : "Adicionar"),
                  onPressed: () async {
                    if (_controller.text.trim().isNotEmpty) {
                      setState(() {
                        if (isEditing && _editingIndex != null) {
                          _postIts[_editingIndex!] = _PostIt(
                            text: _controller.text.trim(),
                            color: _selectedColor,
                          );
                        } else {
                          _postIts.add(
                            _PostIt(text: _controller.text.trim(), color: _selectedColor),
                          );
                        }
                      });
                      await _savePostIts();
                    }
                    _controller.clear();
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostIt(_PostIt postIt, int index) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      onTap: () {
        setState(() {
          _selectedIndex = null;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: postIt.color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                )
              ],
            ),
            child: Text(
              postIt.text,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ),
          if (_selectedIndex == index)
            Positioned(
              top: -10,
              right: -10,
              child: GestureDetector(
                onTap: () {
                  _openPostItModal(isEditing: true, index: index);
                },
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white70,
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.yellow[700],
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("POST-IT", 
        style: TextStyle(
          color: Colors.white70, 
          fontSize: 16,
          fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.white70,
        elevation: 1,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: _postIts.asMap().entries.map((e) => _buildPostIt(e.value, e.key)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPostItModal(),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.white70,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PostIt {
  final String text;
  final Color color;

  _PostIt({required this.text, required this.color});

  Map<String, dynamic> toJson() => {
        "text": text,
        "color": color.value,
      };

  factory _PostIt.fromJson(Map<String, dynamic> json) {
    return _PostIt(
      text: json["text"],
      color: Color(json["color"]),
    );
  }
}
