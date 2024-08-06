public class TaskManagementSystem {
    private static class Node {
        Task task;
        Node next;

        Node(Task task) {
            this.task = task;
        }
    }

    private Node head;

    public void addTask(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
    }

    public Task searchTask(int taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId() == taskId) {
                return current.task;
            }
            current = current.next;
        }
        return null;
    }

    public void traverseTasks() {
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
    }

    public void deleteTask(int taskId) {
        if (head == null) {
            return;
        }
        if (head.task.getTaskId() == taskId) {
            head = head.next;
            return;
        }
        Node current = head;
        while (current.next != null) {
            if (current.next.task.getTaskId() == taskId) {
                current.next = current.next.next;
                return;
            }
            current = current.next;
        }
        System.out.println("Task not found with ID: " + taskId);
    }

    public static void main(String[] args) {
        TaskManagementSystem tms = new TaskManagementSystem();

        tms.addTask(new Task(1, "Debug", "In Progress"));
        tms.addTask(new Task(2, "Run", "Not Started"));
        tms.addTask(new Task(3, "Test", "Not Started"));

        System.out.println("All Tasks:");
        tms.traverseTasks();

        Task task = tms.searchTask(2);
        if (task != null) {
            System.out.println("\nTask Found: " + task);
        } else {
            System.out.println("\nTask not found");
        }

        tms.deleteTask(3);
        System.out.println("\nAfter Deletion:");
        tms.traverseTasks();
    }
}