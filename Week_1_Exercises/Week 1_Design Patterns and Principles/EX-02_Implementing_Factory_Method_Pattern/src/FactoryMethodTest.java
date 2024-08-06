public class FactoryMethodTest {
    public static void main(String[] args) {
        DocumentFactory wordFactory = new WordDocumentFactory();
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        DocumentFactory excelFactory = new ExcelDocumentFactory();

        Document wordDocument = wordFactory.createDocument();
        Document pdfDocument = pdfFactory.createDocument();
        Document excelDocument = excelFactory.createDocument();

        wordDocument.open();
        wordDocument.save();
        wordDocument.close();

        pdfDocument.open();
        pdfDocument.save();
        pdfDocument.close();

        excelDocument.open();
        excelDocument.save();
        excelDocument.close();
    }
}
