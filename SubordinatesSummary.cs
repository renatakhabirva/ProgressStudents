//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProgressStudents
{
    using System;
    using System.Collections.Generic;
    
    public partial class SubordinatesSummary
    {
        public int SubID { get; set; }
        public int SubSummary { get; set; }
        public int SubStudent { get; set; }
        public string SubGrade { get; set; }
    
        public virtual Students Students { get; set; }
        public virtual Summary Summary { get; set; }
    }
}