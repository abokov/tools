/*
   example which illustrate access to SGE via DRMAA interface - running a job on
   specified queue or host with optional using 'hard' or 'soft' resource requirement, 
   wait or not wait till job will finished 
*/
package net.bokov.sge;


import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.Iterator;

import org.ggf.drmaa.DrmaaException;
import org.ggf.drmaa.JobTemplate;
import org.ggf.drmaa.Session;
import org.ggf.drmaa.SessionFactory;
import org.ggf.drmaa.JobInfo;



public class SgeDrmaaJobRunner {
    public enum RequestType { Soft, Hard };
    public enum ResourceType { Host, Queue };

    public static void main(String[] args) {
       System.out.println("usage : [soft|hard] [host|queue] [wait|not_wait] job_path resource_name");

       if (args.length < 4 ) {
            System.out.println("Quit by error - wrong command line\n");
            return;
       }
       SgeDrmaaJobRunner job_runner = new SgeDrmaaJobRunner();
       RequestType type = RequestType.Soft;
       ResourceType res_type = ResourceType.Host;

       if  (new String("hard").equalsIgnoreCase(args[0]) ) {
           type = RequestType.Hard;
       } else if (new String("soft").equalsIgnoreCase(args[0])) {
           type = RequestType.Soft;
       } else {
            System.out.println("Quit by error - expect [soft|hard]\n");
            return;
       }
       
       if  (new String("host").equalsIgnoreCase(args[1]) ) {
           res_type = ResourceType.Host;
       } else if (new String("queue").equalsIgnoreCase(args[1])) {
           res_type = ResourceType.Queue;
       } else {
            System.out.println("Quit by error - expect [host|queue]\n");
            return;
       }
       
       boolean wait_till_done = false;
       if  (new String("wait").equalsIgnoreCase(args[2]) ) {
           wait_till_done = true;
       } else if (new String("not_wait").equalsIgnoreCase(args[2])) {
           wait_till_done = false;
       } else {
            System.out.println("Quit by error - expect [wait|not_wait]\n");
            return;
       }
       
       job_runner.runJob(type, res_type, wait_till_done, args[3], args[4]);
    }

    public void runJob(RequestType type, ResourceType res_type, 
    		boolean wait_till_done, String job,  String res_name) {
       SessionFactory factory = SessionFactory.getFactory();
       Session session = factory.getSession();

       try {
          session.init("");
          JobTemplate jt = session.createJobTemplate();
          jt.setRemoteCommand(job);
          String spec = "";
          switch (type) {
          	case Soft: spec = "-soft ";
            break;
              
            case Hard: spec = "-hard ";
            break;
          };
          
          switch (res_type) {
          	case Host: spec += "-l hostname=";
          	break;
          
          	case Queue: spec += "-q ";
          	break;
          }
          spec += res_name;

          System.out.println("Use specification : " + spec);
          
//          jt.setNativeSpecification(spec); 

          String id = session.runJob(jt);

          System.out.println("Your job has been submitted with id " + id);

          session.deleteJobTemplate(jt);

          
          if (wait_till_done == false)
              return;
          
          JobInfo info = session.wait(id, Session.TIMEOUT_WAIT_FOREVER);

          if (info.wasAborted()) {
             System.out.println("Job " + info.getJobId() + " never ran");
          } else if (info.hasExited()) {
             System.out.println("Job " + info.getJobId() +
                   " finished regularly with exit status " +
                   info.getExitStatus());
          } else if (info.hasSignaled()) {
             System.out.println("Job " + info.getJobId() +
                   " finished due to signal " +
                   info.getTerminatingSignal());
          } else {
             System.out.println("Job " + info.getJobId() +
                   " finished with unclear conditions");
          }

          System.out.println("Job Usage:");

          Map rmap = info.getResourceUsage();
          Iterator i = rmap.keySet().iterator();

          while (i.hasNext()) {
             String name = (String)i.next();
             String value = (String)rmap.get(name);

             System.out.println("  " + name + "=" + value);
          }

          session.exit();
       } catch (DrmaaException e) {
          System.out.println("Error: " + e.getMessage());
       }

    }
}


