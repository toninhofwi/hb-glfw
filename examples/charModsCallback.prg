/*
   Test char mods callback.
   This function sets the character with modifiers callback of the specified window, which is called when a Unicode character is input regardless of what modifier keys are used.
   glfwSetCharModsCallback( pWindow, @char_mods_callback() )
*/

#include "hbglfw.ch"

PROCEDURE Main()

   LOCAL pWindow
   LOCAL nWidth, nHeight

   glfwSetErrorCallback( @error_callback() )

   IF ! glfwInit()
      OutStd( e"\nFailed to initialize GLFW" )
      RETURN
   ENDIF

   pWindow := glfwCreateWindow( 640, 480, "Prosty przykład", NIL, NIL )

   IF pWindow == NIL
      glfwTerminate()
      OutStd( e"\nFailed to open GLFW Window" )
      RETURN
   ENDIF

   glfwMakeContextCurrent( pWindow )
   gladLoadGL_glfwGetProcAddress()

   glfwSetCharModsCallback( pWindow, @char_mods_callback() )

   DO WHILE ! glfwWindowShouldClose( pWindow )

      glfwGetFramebufferSize( pWindow, @nWidth, @nHeight )

      glViewport( 0, 0, nWidth, nHeight )
      glClear( GL_COLOR_BUFFER_BIT )

      glfwSwapBuffers( pWindow )
      glfwPollEvents()

   ENDDO

   glfwDestroyWindow( pWindow )
   glfwTerminate()

   OutStd( e"\nFinishing..." )

   RETURN

STATIC PROCEDURE error_callback( nError, cDescription )

   HB_SYMBOL_UNUSED( nError )
   OutStd( e"\nError: ", cDescription )

   RETURN

STATIC PROCEDURE char_mods_callback( pWindow, codepoint, mods )

   HB_SYMBOL_UNUSED( pWindow )

   OutStd( Chr( codepoint ), e"\n" )

   IF mods == 1
      OutStd( e"Shift key pressed aswell\n" )
   ENDIF

   RETURN
