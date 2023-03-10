USE [ERP_Asset]
GO
/****** Object:  StoredProcedure [dbo].[sprAssetsReturn]    Script Date: 1/12/2023 11:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Mowaz>
-- Create date: <Jan 8, 2023>
-- Description:	<Asset Return,,>
/*
 exec [dbo].[sprAssetsReturn] 3,0,520881,1683,0,520881,'Hallo'
*/
-- =============================================
ALTER PROCEDURE [dbo].[sprAssetsReturn]
	
@intType int, @intID int, @intEmplID int, @intAssetID int,  @ysnAction int, @intActionBy int, @strReason varchar(200)

AS
BEGIN
	-- Asset Return Data Insert Query
	if(@intType = 1)
	begin
		declare @intUnitID int = (select intUnitID from ERP_HR.dbo.tblEmployee where intEmployeeID = @intEmplID)
		if(not exists(select intAssetsID from ERP_Asset.dbo.tblITAssetReturnPermission where intEmployeeID=@intEmplID and intAssetsID = @intAssetID and isnull(ysnSupApprove,1)=1 and isnull(ysnAdminApprove,1)=1 and isnull(ysnITApproved,1) = 1))
		begin
				INSERT INTO [ERP_Asset].[dbo].[tblITAssetReturnPermission]
				   ([intEmployeeID]
				   ,[intAssetsID]
				   ,[ysnActive],[intLastActionBy],[dteLastActionDate],[intUnitID],[strReason])
				   VALUES(@intEmplID, @intAssetID, 1, @intEmplID, GETDATE(), @intUnitID, @strReason)

				select 'Inserted successfully' strMsg
		end
		else
		begin
			select 'Data is already exist!!!' strMsg
		end
	end
	-- User Asset List dropdown query
	else if(@intType=2)
	begin
		SELECT al.intAssetID, t.strType + ' [' + al.strAssetName + '] ' + ' [' + al.strDetails + '] ' + ' [' + al.strProductNumber + ']' AS strDetails
		FROM tblITAssetsList AS al 
		INNER JOIN tblITAssetType AS t ON al.intType = t.intTypeID 
		INNER JOIN tblITAssetAssignToEmployee AS e ON al.intAssetID = e.intAssetID AND e.ysnActive = 1
		WHERE (al.ysnActive = 1) AND (al.ysnStoreIn = 0) AND (al.ysnInfrastructure = 0) AND (al.intParentID = 0) AND (e.intEnroll = @intEmplID)
	end
	-- Supervisor Asset Approval list
	else if(@intType=3)
	begin
		select tblPer.intID as intID, fEmp.strEmployeeName as EmployeeName, fEmp.intEmployeeID as Enroll, 
				asstTyp.strType +'['+ asseyLis.strAssetName +']'+'['+asseyLis.strDetails+']'+'['+asseyLis.strProductNumber+']' as AssetName, 
				Udes.strDesignation as Employee_Designation, dept.strDepatrment as Department, 
				jobSts.strJobStationName as JobStation, tblPer.strReason as Reason
		From ERP_Asset.dbo.tblITAssetReturnPermission as tblPer
		inner join ERP_HR.dbo.tblEmployee as fEmp on tblPer.intEmployeeID=fEmp.intEmployeeID
		inner join ERP_HR.dbo.tblUserDesignation as Udes on fEmp.intDesignationID=Udes.intDesignationID 
		inner join ERP_HR.dbo.tblUserDesignation as Sdes on fEmp.intDesignationID=Sdes.intDesignationID
		inner join ERP_HR.dbo.tblDepartment as dept ON fEmp.intDepartmentID=dept.intDepartmentID
		inner join ERP_HR.dbo.tblEmployeeJobStation as jobSts on fEmp.intJobStationID=jobSts.intEmployeeJobStationId
		inner join ERP_Asset.dbo.tblITAssetAssignToEmployee as asstAssignEmp on tblPer.intAssetsID=asstAssignEmp.intAssetID
		inner join ERP_Asset.dbo.tblITAssetsList as asseyLis on asstAssignEmp.intAssetID=asseyLis.intAssetID
		inner join ERP_Asset.dbo.tblITAssetType as asstTyp on asseyLis.intType=asstTyp.intTypeID
		where fEmp.intSuperviserId = @intEmplID
		and tblPer.ysnSupApprove is null
	end
	-- Supervisor Asset Approv query
	else if(@intType=4)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET ysnSupApprove = 1, intSupApproveBy= @intEmplID, dteSupervisonApprovedTime= GETDATE()
		WHERE intID = @intID
	end
	-- Supervisor Asset Reject Query
	else if(@intType=5)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET ysnSupApprove = 0, intSupApproveBy= @intEmplID, dteSupervisonApprovedTime= GETDATE(), strRejectReason= @strReason
		WHERE intID = @intID
	end
	-- Admin Asset Approval list
	else if(@intType=6)
	begin
		select tblPer.intID as intID, fEmp.strEmployeeName as EmployeeName, fEmp.intEmployeeID as Enroll, 
				asstTyp.strType +'['+ asseyLis.strAssetName +']'+'['+asseyLis.strDetails+']'+'['+asseyLis.strProductNumber+']' as AssetName, 
				Udes.strDesignation as Employee_Designation, dept.strDepatrment as Department, 
				jobSts.strJobStationName as JobStation, fSup.strEmployeeName as supervisor, (case when tblPer.ysnSupApprove = 1 then 'Approved' else 'Decline' end) as Aproved
		From ERP_Asset.dbo.tblITAssetReturnPermission as tblPer
		inner join ERP_HR.dbo.tblEmployee as fEmp on tblPer.intEmployeeID=fEmp.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fSup on tblPer.intSupApproveBy=fSup.intEmployeeID
		inner join ERP_HR.dbo.tblUserDesignation as Udes on fEmp.intDesignationID=Udes.intDesignationID 
		inner join ERP_HR.dbo.tblUserDesignation as Sdes on fEmp.intDesignationID=Sdes.intDesignationID
		inner join ERP_HR.dbo.tblDepartment as dept ON fEmp.intDepartmentID=dept.intDepartmentID
		inner join ERP_HR.dbo.tblEmployeeJobStation as jobSts on fEmp.intJobStationID=jobSts.intEmployeeJobStationId
		inner join ERP_Asset.dbo.tblITAssetAssignToEmployee as asstAssignEmp on tblPer.intAssetsID=asstAssignEmp.intAssetID
		inner join ERP_Asset.dbo.tblITAssetsList as asseyLis on asstAssignEmp.intAssetID=asseyLis.intAssetID
		inner join ERP_Asset.dbo.tblITAssetType as asstTyp on asseyLis.intType=asstTyp.intTypeID
		where tblPer.ysnSupApprove = 1
		and tblPer.ysnAdminApprove is null
	end
	-- Admin Asset Approv query
	else if(@intType=7)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET ysnAdminApprove = 1, intAdminApproveBy= @intEmplID, dteAdminApprovedTime= GETDATE()
		WHERE intID = @intID
	end
	-- Admin Asset Reject query
	else if(@intType=8)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET ysnAdminApprove = 0, intAdminApproveBy= @intEmplID, dteAdminApprovedTime= GETDATE(), strRejectReason= @strReason
		WHERE intID = @intID
	end
	-- IT Asset Approval list
	else if(@intType=9)
	begin
		select tblPer.intID as intID, fEmp.strEmployeeName as EmployeeName, fEmp.intEmployeeID as Enroll, 
				asstTyp.strType +'['+ asseyLis.strAssetName +']'+'['+asseyLis.strDetails+']'+'['+asseyLis.strProductNumber+']' as AssetName, 
				Udes.strDesignation as Employee_Designation, dept.strDepatrment as Department, 
				jobSts.strJobStationName as JobStation, fSup.strEmployeeName as supervisor, (case when tblPer.ysnSupApprove = 1 then 'Approved' else 'Decline' end) as Aproved,
				fAdm.strEmployeeName as AdminAppr, (case when tblPer.ysnAdminApprove=1 then 'Approved' else 'Decline' end) as Approved
		From ERP_Asset.dbo.tblITAssetReturnPermission as tblPer
		inner join ERP_HR.dbo.tblEmployee as fEmp on tblPer.intEmployeeID=fEmp.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fSup on tblPer.intSupApproveBy=fSup.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fAdm on tblPer.intAdminApproveBy=fAdm.intEmployeeID
		inner join ERP_HR.dbo.tblUserDesignation as Udes on fEmp.intDesignationID=Udes.intDesignationID 
		inner join ERP_HR.dbo.tblUserDesignation as Sdes on fEmp.intDesignationID=Sdes.intDesignationID
		inner join ERP_HR.dbo.tblDepartment as dept ON fEmp.intDepartmentID=dept.intDepartmentID
		inner join ERP_HR.dbo.tblEmployeeJobStation as jobSts on fEmp.intJobStationID=jobSts.intEmployeeJobStationId
		inner join ERP_Asset.dbo.tblITAssetAssignToEmployee as asstAssignEmp on tblPer.intAssetsID=asstAssignEmp.intAssetID
		inner join ERP_Asset.dbo.tblITAssetsList as asseyLis on asstAssignEmp.intAssetID=asseyLis.intAssetID
		inner join ERP_Asset.dbo.tblITAssetType as asstTyp on asseyLis.intType=asstTyp.intTypeID
		where tblPer.ysnAdminApprove = 1
		and tblPer.ysnItApproved is null
		and tblPer.ysnComplete is null
	end
	-- IT Asset Approv query
	else if(@intType=10)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET intItApprovedby=@intEmplID, dteItApprvDate= GETDATE(), ysnItApproved=1
		WHERE intID = @intID
	end
	-- IT Asset Reject query
	else if(@intType=11)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET intItApprovedby=@intEmplID, dteItApprvDate= GETDATE(), ysnItApproved=0, strRejectReason= @strReason
		WHERE intID = @intID
	end
	-- Store Man Asset Approval List
	else if(@intType=12)
	begin
		select tblPer.intID as intID, fEmp.strEmployeeName as EmployeeName, fEmp.intEmployeeID as Enroll, 
				asstTyp.strType +'['+ asseyLis.strAssetName +']'+'['+asseyLis.strDetails+']'+'['+asseyLis.strProductNumber+']' as AssetName, 
				Udes.strDesignation as Employee_Designation, dept.strDepatrment as Department, 
				jobSts.strJobStationName as JobStation, fSup.strEmployeeName as supervisor, (case when tblPer.ysnSupApprove = 1 then 'Approved' else 'Decline' end) as Aproved,
				fAdm.strEmployeeName as AdminAppr, (case when tblPer.ysnAdminApprove=1 then 'Approved' else 'Decline' end) as Approved,
				fIT.strEmployeeName as ITAppr, (case when tblPer.ysnItApproved=1 then 'Approved' else 'Decline' end) as ITApproved
		From ERP_Asset.dbo.tblITAssetReturnPermission as tblPer
		inner join ERP_HR.dbo.tblEmployee as fEmp on tblPer.intEmployeeID=fEmp.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fSup on tblPer.intSupApproveBy=fSup.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fAdm on tblPer.intAdminApproveBy=fAdm.intEmployeeID
		inner join ERP_HR.dbo.tblEmployee as fIT on tblPer.intItApprovedby=fIT.intEmployeeID
		inner join ERP_HR.dbo.tblUserDesignation as Udes on fEmp.intDesignationID=Udes.intDesignationID 
		inner join ERP_HR.dbo.tblUserDesignation as Sdes on fEmp.intDesignationID=Sdes.intDesignationID
		inner join ERP_HR.dbo.tblDepartment as dept ON fEmp.intDepartmentID=dept.intDepartmentID
		inner join ERP_HR.dbo.tblEmployeeJobStation as jobSts on fEmp.intJobStationID=jobSts.intEmployeeJobStationId
		inner join ERP_Asset.dbo.tblITAssetAssignToEmployee as asstAssignEmp on tblPer.intAssetsID=asstAssignEmp.intAssetID
		inner join ERP_Asset.dbo.tblITAssetsList as asseyLis on asstAssignEmp.intAssetID=asseyLis.intAssetID
		inner join ERP_Asset.dbo.tblITAssetType as asstTyp on asseyLis.intType=asstTyp.intTypeID
		where tblPer.ysnItApproved = 1
		and tblPer.ysnComplete is null
	end
	-- Store Man Asset Approv
	else if(@intType=13)
	begin
		UPDATE [ERP_Asset].[dbo].[tblITAssetReturnPermission]
		SET intItApprovedby=@intEmplID, dteItApprvDate= GETDATE(), ysnComplete=1
		WHERE intID = @intID
	end
	-- User Asset Return Status
	else if(@intType=14)
	begin
		select tblPer.intID as intID, fEmp.strEmployeeName as EmployeeName, fEmp.intEmployeeID as Enroll, 
			asstTyp.strType +'['+ asseyLis.strAssetName +']'+'['+asseyLis.strDetails+']'+'['+asseyLis.strProductNumber+']' as AssetName, 
			tblPer.intSupApproveBy as SupervisorEnroll,(case when tblPer.ysnSupApprove = 1 then 'Supervisor Approved' when tblPer.ysnSupApprove = 0 then 'Supervisor Rejected' else 'Supervisor Pending' end) as Aproved,
			tblPer.intAdminApproveBy as AdminEnroll, (case  when tblPer.ysnSupApprove = 0 then 'Supervisor Not Approve' when tblPer.ysnAdminApprove=1 then 'Admin Approved' when tblPer.ysnAdminApprove=0 then 'Admin Rejected' else 'Admin Pending' end) as Approved,
			tblPer.intItApprovedby as ITEnroll, (case when tblPer.ysnSupApprove = 0 then 'Supervisor Not Approve' when tblPer.ysnAdminApprove = 0 then 'Admin Not Approve' when tblPer.ysnItApproved=1 then 'IT Approved' when tblPer.ysnItApproved=0 then 'IT Rejected' else 'IT Pending' end) as ITApproved,
			(case when tblPer.ysnSupApprove = 0 then 'Supervisor Not Approved' when tblPer.ysnAdminApprove = 0 then 'Admin Not Approved' when tblPer.ysnItApproved=0 then 'IT Not Approved' when tblPer.ysnComplete=1 then 'Your Product Done' else 'Pending' end) as StoreApproved,
			(case when tblPer.ysnSupApprove=0 then tblPer.strRejectReason when tblPer.ysnAdminApprove=0 then tblPer.strRejectReason when tblPer.ysnItApproved=0 then tblPer.strRejectReason when tblPer.strRejectReason is null then 'No Comments' when tblPer.strRejectReason=' ' then 'No Comments' else 'No Comments' end) as rjctReasn
	From ERP_Asset.dbo.tblITAssetReturnPermission as tblPer
	left join ERP_HR.dbo.tblEmployee as fEmp on tblPer.intEmployeeID=fEmp.intEmployeeID
	left join ERP_HR.dbo.tblEmployee as fSup on tblPer.intSupApproveBy=fSup.intEmployeeID
	left join ERP_HR.dbo.tblEmployee as fAdm on tblPer.intAdminApproveBy=fAdm.intEmployeeID
	left join ERP_HR.dbo.tblEmployee as fIT on tblPer.intItApprovedby=fIT.intEmployeeID
	join ERP_Asset.dbo.tblITAssetAssignToEmployee as asstAssignEmp on tblPer.intAssetsID=asstAssignEmp.intAssetID
	join ERP_Asset.dbo.tblITAssetsList as asseyLis on asstAssignEmp.intAssetID=asseyLis.intAssetID
	join ERP_Asset.dbo.tblITAssetType as asstTyp on asseyLis.intType=asstTyp.intTypeID
	where tblPer.intEmployeeID = @intEmplID
	end
END

 

