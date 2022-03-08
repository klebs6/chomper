
MetaItem :
      SimplePath
   | SimplePath = Expression
   | SimplePath ( MetaSeq? )

MetaSeq :
   MetaItemInner ( , MetaItemInner )* ,?

MetaItemInner :
      MetaItem
   | Expression

MetaWord:
   IDENTIFIER

MetaNameValueStr:
   IDENTIFIER = (STRING_LITERAL | RAW_STRING_LITERAL)

MetaListPaths:
   IDENTIFIER ( ( SimplePath (, SimplePath)* ,? )? )

MetaListIdents:
   IDENTIFIER ( ( IDENTIFIER (, IDENTIFIER)* ,? )? )

MetaListNameValueStr:
   IDENTIFIER ( ( MetaNameValueStr (, MetaNameValueStr)* ,? )? )
