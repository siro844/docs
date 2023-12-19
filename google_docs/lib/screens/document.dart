import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({
    super.key,
  required this.id
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}
class _DocumentScreenState extends ConsumerState<DocumentScreen> {
 TextEditingController titleContoller =TextEditingController(text: 'Untitled Document');
final quill.QuillController _controller=quill.QuillController.basic();
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleContoller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        actions:  [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                ),
                onPressed: (){},
                 icon: const Icon(Icons.lock,color: white,size:16),
                  label: const Text('Share',style: TextStyle(color:white ),)
                  ),
            ),
        ],
        title:Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Image.asset('assets/logo.png',height: 40,),
            const SizedBox(width: 10,),
            SizedBox(
          width: 180,
          child: TextField(
            controller: titleContoller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: blue,
                )
              ),
              contentPadding: EdgeInsets.only(left: 10),

            ),
          ),
            )
          ],
        ),
        ),
         
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
         child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
              width: 0.1
            )
          ),
         )
         ),
      ),
     body:  QuillProvider(
  configurations: QuillConfigurations(
    controller: _controller,
    sharedConfigurations: const QuillSharedConfigurations(
      locale: Locale('de'),
    ),
  ),
  child: Column(
    children: [
      const QuillToolbar(),
      Expanded(
        child: QuillEditor.basic(
          configurations: const QuillEditorConfigurations(
            readOnly: false,
          ),
        ),
      )
    ],
  ),
)
    );
     
  }
}