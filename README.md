# Web Technology Grading

A collection of resources to assist with the automation of grading project-based assignments. Initially created for _Internet/Web Development Level I (CIS133DA)_ at Gateway Community College.

## Canonical Sources

* [GitLab](* https://gitlab.com/comp_sci_edu/web-tech-grading)
* [GitHub](* https://github.com/comp-sci-edu/web-tech-grading)
* [Keybase](keybase://team/comp_sci_edu/web-tech-grading)

## License

This work is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](LICENSE). If you have any questions, visit http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

## Principles

Applying a traditional memorize and test approach to teaching web design and development is doomed to failure because:

* Web technology is too vast. HTML has hundreds of elements and attributes. CSS has thousands of properties. JavaScript is an entire programming language...
* Web technology changes frequently. New things are added, old things are deprecated. There are entire initiatives to keep track of all of this ([caniuse.com](https://caniuse.com/)).
* Design (including web design) is fundamentally about creativity and synthesis.
* Creating websites involves integrating many different technologies and techniques rather than making small, disconnected units.

Further, grading work or any type of metrics based incentivization, is detrimental to creative work. It leads to metrics fixation and inferior performance. It also creates a "cap" which students are likely to stay below. With open-ended, project based work students can and do dramatically exceed the minimum requirements and turn work that is representative of their true capabilities.

### Articles

* [I no longer grade my students’ work, and I wish I had stopped sooner](https://theconversation.com/i-no-longer-grade-my-students-work-and-i-wish-i-had-stopped-sooner-179617)
* Pending additions...

## Approach

When teaching web design, the best approach I have found thus far:

* Instructors should tend toward live coding rather than traditional lecture.
* The futility of intentional memorization in the web design space should be emphasized. It's good for students to see that instructors look things up in docs frequently.
* The difference between reference documentation and tutorials/guides should be explained. References give excessive detail, tutorials/guides demonstrate integration of techniques and technologies toward a goal.
* Assignments should be project based work of the students choosing (resume website, personal interest website, etc.).
* Collaboration between students should be encouraged throughout class. However, on most assignments each student should turn in their own project, even if they worked as a group i.e. 3 students working in a group will turn in 3 separate projects.
* Discuss the difference between copying code snippets to create a certain component or achieve a certain look and actual plagiarism which is copying of content.
* Show students how to find and use CSS frameworks, HTML components, free image assets, and free icons and artwork.
* Licensing terms and attribution are important. Have students demonstrate how and where to find terms and evaluate whether they are compatible with their project.

## Assignment Submissions

**All assignments that are actual code should be turned in via Git repositories.**

Git (and other Distributed Version Control Systems (DVCS)) are standard parts of a professional software development workflow. Students should be exposed to these tools and become proficient with their use even for small projects in entry level classes.

Using LMS based "turn it in" solutions do a disservice to students, their future employers, and the general public. Lack of familiarity with proper version control systems and methodologies leads to lost work, lower quality code, unnecessarily lengthened troubleshooting sessions, and difficulties properly integrating code on group and real world projects.

The best way to integrate Git repos with Canvas and other LMSs is to have students submit a link to the repository URL.

## Grading

The most difficult aspect of implementing the above in a traditional educational setting is keeping grading effort manageable.

In today's classroom, Learning Management Systems (LMS) are common. Most LMSs tend to have built-in quiz, test, and other automated grading features that can drastically reduce the amount of time and effort spent by teachers. Reducing unnecessary work for teachers is critically important to ensure that their limited time is spent on higher impact planning and instruction of students.

In order to meet the above goals while keeping grading time manageable on heterogenous student projects, it's important to automate as much of the grading process as possible. Fortunately, modern web development tooling is robust allowing us to automate most code quality assessments without forcing students to all work on clones of the same project.

## Tooling

The tooling available consists of validators, linters, formatters, processors, accessibility checkers, and various other static analysis tools that can find, and in some cases automatically correct, errors and omissions in code. Further, modern text editors, Integrated Development Environments (IDE), and web browsers have many such tools built-in allowing students to get immediate feedback on things that need to be added or corrected. **Use of such tools by students should be strongly encouraged as it is best practice in the industry.**

For students without access to a suitable development machine, online versions or equivalents of almost every tool are available. Students will not get the realtime feedback from built-in tooling, but they can still be sure that their code is correct with only one or two extra steps.

For Command Line Interface (CLI) convenience functions to make grading easier using these tools, see the [grading.zsh](grading.zsh) file. The functions were written for Zsh on macOS but should be easy to adapt to other shells and platforms.
