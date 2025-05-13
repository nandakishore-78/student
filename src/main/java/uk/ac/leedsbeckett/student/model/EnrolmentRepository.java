package uk.ac.leedsbeckett.student.model;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Inherit database interaction functionality from JpaRepository for Enrolment class, of ID type Long
 * Create new Enrolment *
 * Update existing Enrolment *
 * Delete Enrolment *
 * Find Enrolment (one, all, or search by simple or complex properties)
 */
public interface EnrolmentRepository extends JpaRepository<Enrolment, Long> {
    Enrolment findEnrolmentByCourseAndStudent(Course course, Student student);
    List<Enrolment> findEnrolmentByStudent(Student student);
}
