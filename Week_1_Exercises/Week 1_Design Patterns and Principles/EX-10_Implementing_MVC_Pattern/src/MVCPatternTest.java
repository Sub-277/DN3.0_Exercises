public class MVCPatternTest {
    public static void main(String[] args) {
        Student student = new Student("1", "Subarna Paul", "A");

        StudentView view = new StudentView();

        StudentController controller = new StudentController(student, view);

        controller.updateView();

        controller.setStudentName("Sagnik Kundu");
        controller.setStudentGrade("B");

        controller.updateView();
    }
}
