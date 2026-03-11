import $ from "jquery";
import DataTable from "datatables.net";
DataTable($);

import { initializeDataTable } from "../../datatable";

$(() => {
  initializeDataTable("table.admin-list");
  initializeDataTable("table.organization-list");
});
