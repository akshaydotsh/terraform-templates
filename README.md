## Getting Started

Clone the repo
```
$ git clone git@github.com:theakshaygupta/terraform-templates.git
```

Install Terraform and set permissions to scripts through:
```
$ make deps
```

That's it! You can get your infrastructure up and running now.


### Example
```bash
$ make fargate
$ make destroy-fargate
```



## Available 
You can check for availability in Makefile to make sure there are no conflicts but available are:
```bash
- acm // Certificate Manager
- fargate
- vpc // custom with high-availability
- static-webhosting // including cloudfront distribution
```