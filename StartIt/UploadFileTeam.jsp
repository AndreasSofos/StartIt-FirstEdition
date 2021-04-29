<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@ page import="StartitClasses.*, java.util.List"%>

<%   
   ServletContext context = pageContext.getServletContext();
   int startupID=0;
   File file;
   int maxFileSize = 6016 * 4000;
   int maxMemSize = 6016 * 4000;
   String filePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\ismgroup79\\StartIt\\TeamUploads\\";

   // Verify the content type
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               //String fileName = fi.getName();
               //String fileName = "sofos.png";
               String fileName = startupID + ".jpg";
               
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
            
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
               fi.write( file ) ;
               String site = new String("Startit-team-profile.jsp?startup="+startupID);
               response.setStatus(response.SC_MOVED_TEMPORARILY);
               response.setHeader("Location", site); 

               
            } else{
               %> htan <%
               %> enas <%
               InputStream inputstr = fi.getInputStream();
               %> magkas <%
               BufferedReader d = new BufferedReader(new InputStreamReader(inputstr));        
               %> ston  <%      
               startupID = Integer.parseInt(d.readLine());
               %> Votaniko <%


            }
         }
         out.println("</body>");
         out.println("</html>");
      } catch(Exception ex) {%>
	 <!-- String site = new String("Startit-myteams.jsp?");
         response.setStatus(response.SC_MOVED_TEMPORARILY);
         response.setHeader("Location", site); 
         System.out.println(ex); -->
      <%}
   } else {
      String site = new String("Startit-team-profile.jsp?startup="+startupID);
      response.setStatus(response.SC_MOVED_TEMPORARILY);
      response.setHeader("Location", site); 
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>