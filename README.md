# db-schema-mgmt-mysql
Schema Management for MySQL

```

## Feature branching and release cycle
### Schema release git workflow
> Based on [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) with one major difference.  
> GitFlow starts releases from `develop` branch.  
> We start releases from `master` branch.
<img src="B2EFlow.svg" width="600" />

1. Create a `feature` branch from `master`.
2. Make changes and test them locally.
3. Commit and push changes into the `feature` branch.
4. Merge `feature` branch into the `dev` branch.
5. Deploy `dev` branch into the `Dev` environment.
> Via CI/CD
6. Test the `Dev` environment.
7. Merge `feature` branch into the `int` branch.
8. Deploy `int` branch into the `Int` environment.
> Via CI/CD
9. Test the `Int` environment.
10. Merge `feature` branch into the `master` branch.
11. Tag `master` branch with a version.
12. Deploy the `tag` into the `Prod` environment.
> Via CI/CD


### Branch naming conventions
Each change branch should start with either a `feature/change_` or a `feature/rollback_` prefix to make it easier to track the purpose of the change.

1. Add an index
> feature/change_application_name_1.2.3

2. Rollback
> feature/rollback_application_name_1.2.3
