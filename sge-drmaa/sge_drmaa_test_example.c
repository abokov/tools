/*
   example which illustrate access to SGE via DRMAA interface - running a job on
   specified queue with optional using 'hard' or 'soft' resource requirement.
*/


#include <stdio.h>
#include <string.h>
#include "drmaa.h"
  
int main(int argc, char **argv) {
     char error[DRMAA_ERROR_STRING_BUFFER];
     int errnum = 0;
     drmaa_job_template_t *jt = NULL;
  
     errnum = drmaa_init(NULL, error, DRMAA_ERROR_STRING_BUFFER);
  
     if (errnum != DRMAA_ERRNO_SUCCESS) {
        fprintf(stderr, "Could not initialize the DRMAA library: %s\n", error);
        return 1;
     }
  
     errnum = drmaa_allocate_job_template(&jt, error, DRMAA_ERROR_STRING_BUFFER);
  
     if (errnum != DRMAA_ERRNO_SUCCESS) {
        fprintf(stderr, "Could not create job template: %s\n", error);
     }
     else {
        errnum = drmaa_set_attribute(jt, DRMAA_REMOTE_COMMAND, "/tools/sleeper_hard.sh",
                                      error, DRMAA_ERROR_STRING_BUFFER);
				      
        if (errnum != DRMAA_ERRNO_SUCCESS) {
	                    fprintf(stderr, "Could not set attribute \"%s\": %s\n",
			                            DRMAA_REMOTE_COMMAND, error);
	} else												      
    	    if (argc == 2) {
		char queue_buf[120];
		strcpy(queue_buf,"-hard -q ");
    		strcat(queue_buf, argv[1]);
    		printf("send job to queue : %s\n", queue_buf);			      
    		errnum = drmaa_set_attribute(jt, DRMAA_NATIVE_SPECIFICATION, queue_buf, error, DRMAA_ERROR_STRING_BUFFER - 1);				      
	};
        if (errnum != DRMAA_ERRNO_SUCCESS) 
        	    fprintf(stderr, "Could not set attribute \"%s\": %s\n",
                	DRMAA_REMOTE_COMMAND, error);
        else {
           const char *args[2] = {"5", NULL};
           
           errnum = drmaa_set_vector_attribute(jt, DRMAA_V_ARGV, args, error,
                                                DRMAA_ERROR_STRING_BUFFER);
        }
        
        if (errnum != DRMAA_ERRNO_SUCCESS) {
           fprintf(stderr, "Could not set attribute \"%s\": %s\n",
                    DRMAA_REMOTE_COMMAND, error);
        }
        else {
	    char jobid[DRMAA_JOBNAME_BUFFER];
  
	     errnum = drmaa_run_job(jobid, DRMAA_JOBNAME_BUFFER, jt, error,
                                   DRMAA_ERROR_STRING_BUFFER);
  
	    if (errnum != DRMAA_ERRNO_SUCCESS) {
              fprintf(stderr, "Could not submit job: %s\n", error);
           }
           else {
              printf("Your job has been submitted with id %s\n", jobid);
           }
        } /* else */
  
        errnum = drmaa_delete_job_template(jt, error, DRMAA_ERROR_STRING_BUFFER);
  
        if (errnum != DRMAA_ERRNO_SUCCESS) {
           fprintf(stderr, "Could not delete job template: %s\n", error);
        }
     } /* else */
  
     errnum = drmaa_exit(error, DRMAA_ERROR_STRING_BUFFER);
  
     if (errnum != DRMAA_ERRNO_SUCCESS) {
        fprintf(stderr, "Could not shut down the DRMAA library: %s\n", error);
        return 1;
     }
  
     return 0;
  }
 
