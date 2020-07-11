import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:education/localization/localizations.dart';
import 'package:education/models/addFormula.dart';
import 'package:education/widgets/tags-editor.dart';
import 'package:education/widgets/title-editor-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:zefyr/zefyr.dart';

class FormulaEditorWidget extends StatefulWidget {
  final ZefyrScope editor;

  const FormulaEditorWidget({Key key, this.editor}) : super(key: key);
  @override
  _FormulaEditorWidgetState createState() => _FormulaEditorWidgetState();
}

class _FormulaEditorWidgetState extends State<FormulaEditorWidget> {
  TextEditingController _controller;
  TextEditingController _titleController;
  List<String> tags = List<String>();
  String svg = '''
    <svg xmlns:xlink="http://www.w3.org/1999/xlink" width="28.371ex" height="6.176ex" style="vertical-align: -2.338ex;"
	viewBox="0 -1652.5 12215.4 2659.1" role="img" focusable="false" xmlns="http://www.w3.org/2000/svg"
	aria-labelledby="MathJax-SVG-1-Title">
	<title id="MathJax-SVG-1-Title">\sqrt{\frac{1}{k} \log_2 f(x)} \quad\sqrt{\tfrac{1}{k}\log_2 f(x)}</title>
	<defs aria-hidden="true">
		<path stroke-width="1" id="E1-MJMAIN-31"
			d="M213 578L200 573Q186 568 160 563T102 556H83V602H102Q149 604 189 617T245 641T273 663Q275 666 285 666Q294 666 302 660V361L303 61Q310 54 315 52T339 48T401 46H427V0H416Q395 3 257 3Q121 3 100 0H88V46H114Q136 46 152 46T177 47T193 50T201 52T207 57T213 61V578Z">
		</path>
		<path stroke-width="1" id="E1-MJMATHI-6B"
			d="M121 647Q121 657 125 670T137 683Q138 683 209 688T282 694Q294 694 294 686Q294 679 244 477Q194 279 194 272Q213 282 223 291Q247 309 292 354T362 415Q402 442 438 442Q468 442 485 423T503 369Q503 344 496 327T477 302T456 291T438 288Q418 288 406 299T394 328Q394 353 410 369T442 390L458 393Q446 405 434 405H430Q398 402 367 380T294 316T228 255Q230 254 243 252T267 246T293 238T320 224T342 206T359 180T365 147Q365 130 360 106T354 66Q354 26 381 26Q429 26 459 145Q461 153 479 153H483Q499 153 499 144Q499 139 496 130Q455 -11 378 -11Q333 -11 305 15T277 90Q277 108 280 121T283 145Q283 167 269 183T234 206T200 217T182 220H180Q168 178 159 139T145 81T136 44T129 20T122 7T111 -2Q98 -11 83 -11Q66 -11 57 -1T48 16Q48 26 85 176T158 471L195 616Q196 629 188 632T149 637H144Q134 637 131 637T124 640T121 647Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-6C"
			d="M42 46H56Q95 46 103 60V68Q103 77 103 91T103 124T104 167T104 217T104 272T104 329Q104 366 104 407T104 482T104 542T103 586T103 603Q100 622 89 628T44 637H26V660Q26 683 28 683L38 684Q48 685 67 686T104 688Q121 689 141 690T171 693T182 694H185V379Q185 62 186 60Q190 52 198 49Q219 46 247 46H263V0H255L232 1Q209 2 183 2T145 3T107 3T57 1L34 0H26V46H42Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-6F"
			d="M28 214Q28 309 93 378T250 448Q340 448 405 380T471 215Q471 120 407 55T250 -10Q153 -10 91 57T28 214ZM250 30Q372 30 372 193V225V250Q372 272 371 288T364 326T348 362T317 390T268 410Q263 411 252 411Q222 411 195 399Q152 377 139 338T126 246V226Q126 130 145 91Q177 30 250 30Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-67"
			d="M329 409Q373 453 429 453Q459 453 472 434T485 396Q485 382 476 371T449 360Q416 360 412 390Q410 404 415 411Q415 412 416 414V415Q388 412 363 393Q355 388 355 386Q355 385 359 381T368 369T379 351T388 325T392 292Q392 230 343 187T222 143Q172 143 123 171Q112 153 112 133Q112 98 138 81Q147 75 155 75T227 73Q311 72 335 67Q396 58 431 26Q470 -13 470 -72Q470 -139 392 -175Q332 -206 250 -206Q167 -206 107 -175Q29 -140 29 -75Q29 -39 50 -15T92 18L103 24Q67 55 67 108Q67 155 96 193Q52 237 52 292Q52 355 102 398T223 442Q274 442 318 416L329 409ZM299 343Q294 371 273 387T221 404Q192 404 171 388T145 343Q142 326 142 292Q142 248 149 227T179 192Q196 182 222 182Q244 182 260 189T283 207T294 227T299 242Q302 258 302 292T299 343ZM403 -75Q403 -50 389 -34T348 -11T299 -2T245 0H218Q151 0 138 -6Q118 -15 107 -34T95 -74Q95 -84 101 -97T122 -127T170 -155T250 -167Q319 -167 361 -139T403 -75Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-32"
			d="M109 429Q82 429 66 447T50 491Q50 562 103 614T235 666Q326 666 387 610T449 465Q449 422 429 383T381 315T301 241Q265 210 201 149L142 93L218 92Q375 92 385 97Q392 99 409 186V189H449V186Q448 183 436 95T421 3V0H50V19V31Q50 38 56 46T86 81Q115 113 136 137Q145 147 170 174T204 211T233 244T261 278T284 308T305 340T320 369T333 401T340 431T343 464Q343 527 309 573T212 619Q179 619 154 602T119 569T109 550Q109 549 114 549Q132 549 151 535T170 489Q170 464 154 447T109 429Z">
		</path>
		<path stroke-width="1" id="E1-MJMATHI-66"
			d="M118 -162Q120 -162 124 -164T135 -167T147 -168Q160 -168 171 -155T187 -126Q197 -99 221 27T267 267T289 382V385H242Q195 385 192 387Q188 390 188 397L195 425Q197 430 203 430T250 431Q298 431 298 432Q298 434 307 482T319 540Q356 705 465 705Q502 703 526 683T550 630Q550 594 529 578T487 561Q443 561 443 603Q443 622 454 636T478 657L487 662Q471 668 457 668Q445 668 434 658T419 630Q412 601 403 552T387 469T380 433Q380 431 435 431Q480 431 487 430T498 424Q499 420 496 407T491 391Q489 386 482 386T428 385H372L349 263Q301 15 282 -47Q255 -132 212 -173Q175 -205 139 -205Q107 -205 81 -186T55 -132Q55 -95 76 -78T118 -61Q162 -61 162 -103Q162 -122 151 -136T127 -157L118 -162Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-28"
			d="M94 250Q94 319 104 381T127 488T164 576T202 643T244 695T277 729T302 750H315H319Q333 750 333 741Q333 738 316 720T275 667T226 581T184 443T167 250T184 58T225 -81T274 -167T316 -220T333 -241Q333 -250 318 -250H315H302L274 -226Q180 -141 137 -14T94 250Z">
		</path>
		<path stroke-width="1" id="E1-MJMATHI-78"
			d="M52 289Q59 331 106 386T222 442Q257 442 286 424T329 379Q371 442 430 442Q467 442 494 420T522 361Q522 332 508 314T481 292T458 288Q439 288 427 299T415 328Q415 374 465 391Q454 404 425 404Q412 404 406 402Q368 386 350 336Q290 115 290 78Q290 50 306 38T341 26Q378 26 414 59T463 140Q466 150 469 151T485 153H489Q504 153 504 145Q504 144 502 134Q486 77 440 33T333 -11Q263 -11 227 52Q186 -10 133 -10H127Q78 -10 57 16T35 71Q35 103 54 123T99 143Q142 143 142 101Q142 81 130 66T107 46T94 41L91 40Q91 39 97 36T113 29T132 26Q168 26 194 71Q203 87 217 139T245 247T261 313Q266 340 266 352Q266 380 251 392T217 404Q177 404 142 372T93 290Q91 281 88 280T72 278H58Q52 284 52 289Z">
		</path>
		<path stroke-width="1" id="E1-MJMAIN-29"
			d="M60 749L64 750Q69 750 74 750H86L114 726Q208 641 251 514T294 250Q294 182 284 119T261 12T224 -76T186 -143T145 -194T113 -227T90 -246Q87 -249 86 -250H74Q66 -250 63 -250T58 -247T55 -238Q56 -237 66 -225Q221 -64 221 250T66 725Q56 737 55 738Q55 746 60 749Z">
		</path>
		<path stroke-width="1" id="E1-MJSZ3-221A"
			d="M424 -948Q422 -947 313 -434T202 80L170 31Q165 24 157 10Q137 -21 137 -21Q131 -16 124 -8L111 5L264 248L473 -720Q473 -717 727 359T983 1440Q989 1450 1001 1450Q1007 1450 1013 1445T1020 1433Q1020 1425 742 244T460 -941Q458 -950 439 -950H436Q424 -950 424 -948Z">
		</path>
		<path stroke-width="1" id="E1-MJSZ2-221A"
			d="M1001 1150Q1017 1150 1020 1132Q1020 1127 741 244L460 -643Q453 -650 436 -650H424Q423 -647 423 -645T421 -640T419 -631T415 -617T408 -594T399 -560T385 -512T367 -448T343 -364T312 -259L203 119L138 41L111 67L212 188L264 248L472 -474L983 1140Q988 1150 1001 1150Z">
		</path>
	</defs>
	<g stroke="" fill="" stroke-width="0" transform="matrix(1 0 0 -1 0 0)" aria-hidden="true">
		<use xlink:href="#E1-MJSZ3-221A" x="0" y="34"></use>
		<rect stroke="none" width="4683" height="60" x="1000" y="1425"></rect>
		<g transform="translate(1000,0)">
			<g transform="translate(120,0)">
				<rect stroke="none" width="641" height="60" x="0" y="220"></rect>
				<use xlink:href="#E1-MJMAIN-31" x="70" y="676"></use>
				<use xlink:href="#E1-MJMATHI-6B" x="60" y="-715"></use>
			</g>
			<g transform="translate(881,0)">
				<use xlink:href="#E1-MJMAIN-6C"></use>
				<use xlink:href="#E1-MJMAIN-6F" x="278" y="0"></use>
				<use xlink:href="#E1-MJMAIN-67" x="779" y="0"></use>
				<use transform="scale(0.707)" xlink:href="#E1-MJMAIN-32" x="1809" y="-343"></use>
			</g>
			<use xlink:href="#E1-MJMATHI-66" x="2781" y="0"></use>
			<use xlink:href="#E1-MJMAIN-28" x="3332" y="0"></use>
			<use xlink:href="#E1-MJMATHI-78" x="3721" y="0"></use>
			<use xlink:href="#E1-MJMAIN-29" x="4294" y="0"></use>
		</g>
		<g transform="translate(6684,0)">
			<use xlink:href="#E1-MJSZ2-221A" x="0" y="-38"></use>
			<rect stroke="none" width="4530" height="60" x="1000" y="1053"></rect>
			<g transform="translate(1000,0)">
				<g transform="translate(120,0)">
					<rect stroke="none" width="488" height="60" x="0" y="220"></rect>
					<use transform="scale(0.707)" xlink:href="#E1-MJMAIN-31" x="95" y="629"></use>
					<use transform="scale(0.707)" xlink:href="#E1-MJMATHI-6B" x="84" y="-617"></use>
				</g>
				<g transform="translate(728,0)">
					<use xlink:href="#E1-MJMAIN-6C"></use>
					<use xlink:href="#E1-MJMAIN-6F" x="278" y="0"></use>
					<use xlink:href="#E1-MJMAIN-67" x="779" y="0"></use>
					<use transform="scale(0.707)" xlink:href="#E1-MJMAIN-32" x="1809" y="-343"></use>
				</g>
				<use xlink:href="#E1-MJMATHI-66" x="2628" y="0"></use>
				<use xlink:href="#E1-MJMAIN-28" x="3179" y="0"></use>
				<use xlink:href="#E1-MJMATHI-78" x="3568" y="0"></use>
				<use xlink:href="#E1-MJMAIN-29" x="4141" y="0"></use>
			</g>
		</g>
	</g>
</svg>
  ''';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(
        text:
            r'\sqrt{\frac{1}{k} \log_2 f(x)} \quad\sqrt{\tfrac{1}{k}\log_2 f(x)}');
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final uuid = Uuid().v4();
          final path = 'formulas/' + uuid + '.svg';
          var stags = List<String>();
          final title = _titleController.text;
          stags.addAll(tags);
          for (var i = 1; i < 5; i++) {
            stags.add(title.substring(0, i));
          }
          stags.add(title);
          final formula = Formula(
              path: path,
              uid: GetIt.I.get<FirebaseUser>().uid,
              tex: _controller.text,
              tags: stags,
              title: title);
          print(formula);
          print('Start uploading');
          final task = FirebaseStorage.instance
              .ref()
              .child(path)
              .putData(utf8.encode(svg));
          await task.onComplete;
          print('Uploaded');
          await Firestore.instance.collection('formulas').add(formula.toJson());
          print('added to firebase');
        },
        child: Icon(Icons.navigate_next),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: svg != null
                      ? SvgPicture.string(
                          svg,
                          color: Colors.white,
                        )
                      : Container(
                          child: Text('Loading'),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations().putFormula,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration:
                        InputDecoration(labelText: AppLocalizations().formula),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        Response response = await Dio().post(
                            'https://us-central1-education-modeck.cloudfunctions.net/checkFireStorage',
                            options: Options(
                                followRedirects: false,
                                contentType: 'text/plain',
                                validateStatus: (status) {
                                  return status < 500;
                                }),
                            data: _controller.text);
                        print(response.statusCode);
                        print(response.statusMessage);
                        print(response.data);
                        if (response.statusCode == 200) {
                          setState(() {
                            svg = response.data;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                      widget.editor.formatSelection(NotusAttribute.embed
                          .image('formula±/' + _controller.text));
                      // Navigator.pop(context);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Text('huis')));
                    },
                    child: Text(AppLocalizations().render),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations().addTitle,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleEditor(controller: _titleController)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TagsEditor(
                    onAddTag: (tag) {
                      tags.add(tag);
                    },
                    onRemoveTag: (tag) {
                      tags.remove(tag);
                    },
                  ),
                ),
                Container(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
