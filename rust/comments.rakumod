LINE_COMMENT :
      // (~[/ !] | //) ~\n*
   | //

BLOCK_COMMENT :
      /* (~[* !] | ** | BlockCommentOrDoc) (BlockCommentOrDoc | ~*/)* */
   | /**/
   | /***/

INNER_LINE_DOC :
   //! ~[\n IsolatedCR]*

INNER_BLOCK_DOC :
   /*! ( BlockCommentOrDoc | ~[*/ IsolatedCR] )* */

OUTER_LINE_DOC :
   /// (~/ ~[\n IsolatedCR]*)?

OUTER_BLOCK_DOC :
   /** (~* | BlockCommentOrDoc ) (BlockCommentOrDoc | ~[*/ IsolatedCR])* */

BlockCommentOrDoc :
      BLOCK_COMMENT
   | OUTER_BLOCK_DOC
   | INNER_BLOCK_DOC

IsolatedCR :
   A \r not followed by a \n
