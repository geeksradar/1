#! /bin/bash
#Cloud Storage Lab
#Initializing Configuration
gcloud init < a

cookie='_ga=GA1.2.138603024.1606913934; variant_determinant=977; __zlcmid=11Sjd3qnsQYUTDd; _gid=GA1.2.1729571221.1607585941; ajs_user_id=%22run-77d3bb4a61ea0be45d7bf1417d59fb1a%22; ajs_anonymous_id=%220205f4ca-a2a0-4bb0-8700-67a8e7983f28%22; _gat=1; _cvl-4_1_14_session=YjRuQzNPWmpGaDZUN1ovRld6TTZWZmFFVlJmUDFRei82VmRZRkZ6L2hFanBpOGY2aFBFbVk4MnlueDNWcUl2ZmdJYmpzRUs1UnlHQ2hUT3hRTkdwdkhBS01GbTh0OGJJeVFhMUNjTTEweFVxcGEvT2g1VjA1bzB2UVVBbHFnUVEwSVFVMkVHcVZjMHAwOTZIdjUrUTJqZTNrcTBMS0JldW91N2RpMGNsdzAyTU95ek1iZUFDZkEzUzI3aHcyekdoYUFmOUc3WU5GeGUzWWRkMWk5UE1kM3FHV3B5UUZ4M1hsMy8zK3J0OXdwYkN0RitwTDlCK0FIOU5xR3ZITWphUmtGbWREZU1aS1oxRG5Yd0I3ZUJLN3JNWmN2TkxLTnNxc0NhOW9VVkJET1R5QS8zcVhDZldrVXZiS2QwK09ySzFvNnFHcWNUa3hTT2xLSlk3ZWhWazZ5KzFhYmpnSFA5MXdLdSthTFBSQ2t5R0RvWFBSVHlIUE15VmxhNFZ6a2ZwemZCYUhjVGY0WUJwQXJxVUsvZFU3YVVOQnA1WUlkdGxYMTZXVXhiRVJGY2lWZlVsQ2RURnZzTTkrS3J0Zyszai0teGtjSk90WkZRaHF3aWM3UWNmMDRSQT09--ea9d4128ea694d55b61a01a709c590b1187111b5'
ID=$(gcloud info --format='value(config.project)')
id=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/focuses/show_spl/6485.json?parent=game" | jq -r '.labInstanceId')
echo $id

# Create a GCS Bucket
if  gsutil mb gs://$ID
then
  result1=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=1")

  # Copy an object to a folder in the bucket (ada.jpg)
  if  gsutil cp ./ada.jpg gs://$ID/
  then
    result2=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=2")

    # Make your object publicly accessible
    if  gsutil acl ch -u AllUsers:R gs://$ID/ada.jpg
    then
      result3=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=3")

      quiz1=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Every bucket must have a unique name across the entire Cloud Storage namespace.","is_correct":true,"response":"{\"value\":true}","item_type":"true-false"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      quiz2=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Cloud Storage offers which storage classes:","is_correct":true,"response":"[{\"id\":\"2\",\"title\":\"Coldline\"},{\"id\":\"0\",\"title\":\"Standard\"},{\"id\":\"3\",\"title\":\"Archive\"},{\"id\":\"1\",\"title\":\"Nearline\"}]","item_type":"multiple-select"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      quiz3=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Object names must be unique only within a given bucket.","is_correct":true,"response":"{\"value\":true}","item_type":"true-false"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      
      printf "\n\e[1;92m%s\n\n\e[m" 'Lab Completed'
    fi
  fi
fi
gcloud auth revoke --all
