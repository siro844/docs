import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:google_docs/repository/auth_repository.dart';
import 'package:google_docs/repository/document_repository.dart';
import 'package:google_docs/repository/socket_repository.dart';
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
 ErrorModel? errorModel;
 SocketRepository socketRepository=SocketRepository();
  @override
  void initState() {
    super.initState();
    socketRepository.joinRoom(widget.id);
    fetchDocumentData();
  }
  void fetchDocumentData() async{
  errorModel=await ref.read(documentRepositoryProvider)
  .getDocumentById(ref.read(userProvider)!.token, widget.id);
  
    if(errorModel!.data!=null){
        titleContoller.text=(errorModel!.data as DocumentModel).title;
        setState((){});
    }
  
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleContoller.dispose();
  }

  void updateTitle(WidgetRef ref,String title){
    ref.read(documentRepositoryProvider).updateTitle(token: ref.read(userProvider)!.token,
     id: widget.id,
      title: title);
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
          padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Image.asset('assets/logo.png',height: 40,),
            const SizedBox(width: 10,),
            SizedBox(
          width: 180,
          child: TextField(
            controller: titleContoller,
            onSubmitted: (value)=>updateTitle(ref, value),
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
      locale: Locale('en'),
    ),
  ),
  child: Center(
    child: Column(
      children: [
        SizedBox(height: 10,),
        const QuillToolbar(),
        Expanded(
          child: SizedBox(
            width: 750,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: false,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  ),
)
    );
     
  }
}