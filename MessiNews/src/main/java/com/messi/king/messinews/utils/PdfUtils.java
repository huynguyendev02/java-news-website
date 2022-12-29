package com.messi.king.messinews.utils;

import com.messi.king.messinews.models.Articles;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import org.jsoup.Jsoup;
import org.jsoup.helper.W3CDom;
import org.jsoup.nodes.Document;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class PdfUtils {
    public static void createPdfFile(Articles art, HttpServletRequest request, HttpServletResponse respons) {
        String header = "<html> <head> <meta charset=\"UTF-8\" /> <title>"+ art.getTitle()+"</title> <style> *  { font-family: \"Arial Unicode MS\"; } </style> </head> <body>";
        String titleHTML = "<h1>"+art.getTitle()+"</h1>";
        String footer = "</body></html>";
        String finalHTML = header +titleHTML+ art.getContent() +footer;

        Document document = Jsoup.parse(finalHTML, "UTF-8");
        document.outputSettings().syntax(Document.OutputSettings.Syntax.xml);

        File dir = new File(request.getServletContext().getRealPath("/pdfs/articles/"));
        System.out.println(dir.exists());
        if (!dir.exists()) {
            dir.mkdir();
        }
        try (OutputStream os = new FileOutputStream(request.getServletContext().getRealPath("/pdfs/articles/")+art.getId()+".pdf")) {
            new PdfRendererBuilder()
                    .useFastMode()
                    .useFont(new File(request.getServletContext().getRealPath("/fonts") + "\\arial-unicode-ms.ttf"), "Arial Unicode MS")
                    .withW3cDocument(new W3CDom().fromJsoup(document), null)
                    .toStream(os)
                    .run();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
