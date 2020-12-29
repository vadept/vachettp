module vachettp_router

fn test_route_from_path() {
	//GIVEN
	r := [
		Route{"path", 'vachettp.Controller_test', "index"}
		]
	rtr := Router{r}

	//WHEN
	result := rtr.get_route_by_path ("path")

	//THEN
	assert "path" == result.get_path()
	assert 'vachettp.Controller_test' == result.get_controller_name()
	assert "index" == result.get_function_name()
}
